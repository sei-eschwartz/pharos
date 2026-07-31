// Copyright 2015-2021 Carnegie Mellon University.  See LICENSE file for terms.

#include <stdio.h>
#include <iostream>
#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/graph_utility.hpp>
#include <boost/graph/depth_first_search.hpp>
#include <boost/graph/dijkstra_shortest_paths.hpp>
#include <boost/graph/connected_components.hpp>
#include <time.h>

#include <libpharos/pdg.hpp>
#include <libpharos/misc.hpp>
#include <libpharos/descriptors.hpp>
#include <libpharos/masm.hpp>
#include <libpharos/defuse.hpp>
#include <libpharos/sptrack.hpp>
#include <libpharos/options.hpp>
#include <libpharos/bua.hpp>

#include <gtest/gtest.h>

#include <libpharos/apigraph.hpp>
#include <libpharos/apisig.hpp>

using namespace pharos;

const DescriptorSet* global_ds = nullptr;

// This is the main test fixture
class ApiAnalyzerTest2 : public testing::Test {

 protected:

  ApiGraph api_graph_;

  ApiAnalyzerTest2() : api_graph_(*global_ds) {  }

  virtual void SetUp() {
    // Code here will be called immediately after the constructor (right
    // before each test).
    api_graph_.Build();
  }

  virtual void TearDown() {
    // Code here will be called immediately after each test (right
    // before the destructor).
    api_graph_.Reset();
  }

  void CheckResultTree(rose_addr_t component, std::string &expected_tree, ApiSearchResultVector &results) {

    std::string st = "";
    for (ApiSearchResultVector::iterator ri=results.begin(), end=results.end(); ri!=end; ri++) {
      if (ri->match_component_start == component) {
        for (std::vector<ApiWaypointDescriptor>::iterator pi=ri->search_tree.begin(); pi!=ri->search_tree.end(); pi++) {
          st += addr_str(pi->block->get_address());
        }
        break;
      }
    }
    // this is the correct search tree for the simple inter-procedural search
    EXPECT_EQ(expected_tree,st);
  }
};

// these are tests that concern the ApiCfgComponent class
class ApiAnalyzerInterproceduralTest : public ApiAnalyzerTest2 { };

TEST_F(ApiAnalyzerInterproceduralTest, TEST_NORETURN_WRAPPER_HAS_NO_NORMAL_EXIT) {
  const CallDescriptor *wrapper_call = global_ds->get_call(0x0040107F);
  ASSERT_NE(wrapper_call, nullptr);
  EXPECT_TRUE(wrapper_call->get_never_returns());

  ApiCfgComponentPtr wrapper = api_graph_.GetComponent(0x00401050);
  ASSERT_NE(wrapper, nullptr);
  EXPECT_EQ(wrapper->GetExitAddr(), INVALID_ADDRESS);

  ApiCfgComponentPtr caller = api_graph_.GetComponent(0x00401060);
  ASSERT_NE(caller, nullptr);
  ApiCfgPtr cfg = caller->GetCfg();
  ApiCfgVertex returning_branch = caller->GetVertexByAddr(0x0040107D);
  ApiCfgVertex noreturn_branch = caller->GetVertexByAddr(0x0040107F);
  ASSERT_NE(returning_branch, NULL_VERTEX);
  ASSERT_NE(noreturn_branch, NULL_VERTEX);
  EXPECT_FALSE(boost::edge(returning_branch, noreturn_branch, *cfg).second);
  EXPECT_EQ(boost::out_degree(noreturn_branch, *cfg), ApiCfg::degree_size_type(0));
}

TEST_F(ApiAnalyzerInterproceduralTest, TEST_SHOULD_NOT_FIND_INVALID_INTERPROCEDURAL_SIG) {
  // self-loop + additional APIs
  ApiSig sig;
  sig.name = "TEST_SHOULD_FIND_VALID_SIG_INTERPROCEDURAL";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!GETSTARTUPINOFW"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!GARBAGE")); // Invalid

  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;
  bool r = api_graph_.Search(sig, &results);

  EXPECT_FALSE(r);
  EXPECT_EQ(results.size(),ApiSearchResultVector::size_type(0));

  ApiSig sig2;
  sig2.name = "TEST_SHOULD_FIND_VALID_SIG_INTERPROCEDURAL";
  sig2.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!GETSTARTUPINOFW"));
  sig2.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!READFILE")); // Invalid
  sig2.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!Garbage")); // Valid

  sig2.api_count = sig2.api_calls.size();

  ApiSearchResultVector results2;
  bool r2 = api_graph_.Search(sig2, &results2);

  EXPECT_FALSE(r2);
  EXPECT_EQ(results2.size(),ApiSearchResultVector::size_type(0));
}

// ExitProcess is terminal, so nothing can follow it and this signature must not match.
// Without the progress rollback in ApiSearchState::RevertState the search backtracks out of
// ExitProcess but keeps looking for TerminateProcess, and reports a false match along a path
// that never calls ExitProcess at all:
//
//   0x0040129A PeekNamedPipe .. 0x00401307 WriteFile .. 0x00401336 TerminateProcess
TEST_F(ApiAnalyzerInterproceduralTest, TEST_BACKTRACK_ROLLS_BACK_SIGNATURE_PROGRESS) {

  ApiSig sig;
  sig.name = "TEST_BACKTRACK_ROLLS_BACK_SIGNATURE_PROGRESS";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!PEEKNAMEDPIPE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!EXITPROCESS"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!TERMINATEPROCESS"));
  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;
  bool matched = api_graph_.Search(sig, &results);

  std::string paths;
  for (const ApiSearchResult &result : results) {
    paths += "\n  ";
    for (const ApiWaypointDescriptor &waypoint : result.search_tree) {
      paths += addr_str(waypoint.block->get_address()) + " ";
    }
  }
  EXPECT_FALSE(matched) << "unexpected match:" << paths;
  EXPECT_TRUE(results.empty());
}

// this is a basic inter-procedural signature
TEST_F(ApiAnalyzerInterproceduralTest, TEST_SHOULD_NOT_FIND_INTERPROCEDURAL_SIG) {

  // self-loop + additional APIs
  ApiSig sig;
  sig.name = "TEST_SHOULD_NOT_FIND_INTERPROCEDURAL_SIG";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!PEEKNAMEDPIPE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!WRITEFILE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!CREATEPROCESSA")); // This is in a sub-component

  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;

  bool r = api_graph_.Search(sig, &results);
  EXPECT_FALSE(r);
}

// this is a basic inter-procedural signature
TEST_F(ApiAnalyzerInterproceduralTest, TEST_SHOULD_FIND_VALID_INTERPROCEDURAL_SIG) {

  // self-loop + additional APIs
  ApiSig sig;
  sig.name = "TEST_SHOULD_FIND_VALID_SIG_INTERPROCEDURAL";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!PEEKNAMEDPIPE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!READFILE")); // This is in a sub-component
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!WRITEFILE"));

  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;

  bool r = api_graph_.Search(sig, &results);
  EXPECT_TRUE(r);
  EXPECT_EQ(results.size(), ApiSearchResultVector::size_type(1));

  rose_addr_t component = 0x00401160;
  // "0x0040129A 0x004010D0 0x004010A4 0x00401060 0x00401040 0x0040107D 0x00401307"
  std::string expected = "0x0040129A0x004010D00x004010A40x004010600x004010400x0040107D0x00401307";

  CheckResultTree(component, expected, results);
}

TEST_F(ApiAnalyzerInterproceduralTest, TEST_SHOULD_FIND_SIG_ENDING_AT_EXITPROCESS) {
  ApiSig sig;
  sig.name = "TEST_SHOULD_FIND_SIG_ENDING_AT_EXITPROCESS";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!PEEKNAMEDPIPE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!READFILE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!EXITPROCESS"));
  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;
  EXPECT_TRUE(api_graph_.Search(sig, &results));
  EXPECT_EQ(results.size(), ApiSearchResultVector::size_type(1));
}

TEST_F(ApiAnalyzerInterproceduralTest, TEST_SHOULD_NOT_CONTINUE_AFTER_EXITPROCESS) {
  ApiSig sig;
  sig.name = "TEST_SHOULD_NOT_CONTINUE_AFTER_EXITPROCESS";
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!PEEKNAMEDPIPE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!READFILE"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!EXITPROCESS"));
  sig.api_calls.push_back(ApiSigFunc("KERNEL32.DLL!WRITEFILE"));
  sig.api_count = sig.api_calls.size();

  ApiSearchResultVector results;
  bool matched = api_graph_.Search(sig, &results);
  std::string paths;
  for (const ApiSearchResult &result : results) {
    if (!paths.empty()) paths += "; ";
    for (const ApiWaypointDescriptor &waypoint : result.search_tree) {
      if (!paths.empty() && paths.back() != ' ') paths += " -> ";
      paths += addr_str(waypoint.block->get_address());
    }
  }
  EXPECT_FALSE(matched) << "unexpected paths: " << paths;
  EXPECT_TRUE(results.empty());
}

int main(int argc, char **argv) {

  ::testing::InitGoogleTest(&argc, argv);

  set_glog_name("API2");
  ProgOptVarMap vm = parse_cert_options(argc, argv, cert_standard_options());

  // Find calls, functions, and imports.
  DescriptorSet ds(vm);
  // Resolve imports, load API data, etc.
  ds.resolve_imports();
  // Global for just this test program to make gtest happy.
  global_ds = &ds;

  BottomUpAnalyzer bua(ds, vm);
  bua.analyze();

  int rc = RUN_ALL_TESTS();
  global_rops.reset();
  return rc;
}
