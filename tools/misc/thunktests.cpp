// Copyright 2026 Carnegie Mellon University.  See LICENSE file for terms.
//
// Semantic tests for adjusting thunk recognition, run against tests/itanium_thunks.exe.  The
// partitioner golden output for that specimen only proves which function owns which basic
// block; these tests assert the property that actually drives the object oriented analysis,
// namely that FunctionDescriptor::is_thunk() is true and reports the right target and
// this-pointer adjustment.

#include <libpharos/descriptors.hpp>
#include <libpharos/funcs.hpp>
#include <libpharos/misc.hpp>
#include <libpharos/options.hpp>

#include <gtest/gtest.h>

using namespace pharos;

const DescriptorSet* global_ds = nullptr;

namespace {

struct ThunkCase {
  const char* name;
  rose_addr_t entry;
  rose_addr_t target;
  int64_t fixed_delta;
  // Whether the thunk reads a vcall-offset, and the displacement of the slot if it does.
  bool is_virtual;
  int64_t virtual_slot;
};

const ThunkCase thunk_cases[] = {
  {"thunk_fixed_add",      0x401109, 0x401185,   8, false,   0},
  {"thunk_fixed_sub",      0x40110f, 0x40118b,  -8, false,   0},
  {"thunk_fixed_lea",      0x401115, 0x401191,  16, false,   0},
  {"thunk_virtual",        0x40111b, 0x401197,   0, true,  -24},
  {"thunk_combined",       0x401124, 0x40119d, -16, true,  -32},
  {"thunk_cet",            0x401131, 0x4011a3,   0, true,  -40},
  {"thunk_sret_fixed",     0x40113e, 0x4011a9,   8, false,   0},
  {"thunk_sret_virtual",   0x401144, 0x4011af,   0, true,  -24},
  {"thunk_sret_combined",  0x40114d, 0x4011b5, -16, true,  -32},
};

// Near misses that must remain ordinary functions, plus main() for good measure.
const ThunkCase non_thunk_cases[] = {
  {"not_thunk_wrong_this",       0x40115a, 0, 0, false, 0},
  {"not_thunk_mixed_this",       0x401163, 0, 0, false, 0},
  {"not_thunk_wrong_scratch",    0x401170, 0, 0, false, 0},
  {"not_thunk_zero_adjustment",  0x401179, 0, 0, false, 0},
  {"not_thunk_indirect_jump",    0x40117f, 0, 0, false, 0},
  {"main",                       0x401106, 0, 0, false, 0},
};

} // namespace

TEST(ItaniumThunks, AdjustingThunksAreThunks) {
  for (const ThunkCase& tc : thunk_cases) {
    SCOPED_TRACE(tc.name);
    const FunctionDescriptor* fd = global_ds->get_func(tc.entry);
    ASSERT_NE(fd, nullptr);

    EXPECT_TRUE(fd->is_thunk());
    EXPECT_EQ(fd->get_jmp_addr(), tc.target);

    auto adjustment = fd->get_thunk_adjustment();
    ASSERT_TRUE(bool(adjustment));
    EXPECT_EQ(adjustment->fixed_delta, tc.fixed_delta);
    EXPECT_EQ(bool(adjustment->virtual_slot), tc.is_virtual);
    if (adjustment->virtual_slot && tc.is_virtual) {
      EXPECT_EQ(*adjustment->virtual_slot, tc.virtual_slot);
    }
  }
}

// The thunk target must be a function in its own right, and must know that it is thunked to.
// This is what update_connections() establishes, and what dethunk() ultimately depends on.
TEST(ItaniumThunks, TargetsAreConnected) {
  for (const ThunkCase& tc : thunk_cases) {
    SCOPED_TRACE(tc.name);
    const FunctionDescriptor* target = global_ds->get_func(tc.target);
    ASSERT_NE(target, nullptr);
    EXPECT_FALSE(target->is_thunk());
    EXPECT_TRUE(target->is_thunk_target());

    const FunctionDescriptor* fd = global_ds->get_func(tc.entry);
    ASSERT_NE(fd, nullptr);
    EXPECT_EQ(fd->follow_thunks(), tc.target);
  }
}

TEST(ItaniumThunks, NearMissesAreNotThunks) {
  for (const ThunkCase& tc : non_thunk_cases) {
    SCOPED_TRACE(tc.name);
    const FunctionDescriptor* fd = global_ds->get_func(tc.entry);
    ASSERT_NE(fd, nullptr);

    EXPECT_FALSE(fd->is_thunk());
    EXPECT_EQ(fd->get_jmp_addr(), rose_addr_t(0));
    EXPECT_FALSE(fd->is_adjusting_thunk());
  }
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);

  set_glog_name("THNK");
  ProgOptVarMap vm = parse_cert_options(argc, argv, cert_standard_options());

  // Thunk detection is complete once the descriptor set has been built; no further analysis is
  // required to answer is_thunk().
  DescriptorSet ds(vm);
  global_ds = &ds;

  int rc = RUN_ALL_TESTS();
  global_rops.reset();
  return rc;
}
