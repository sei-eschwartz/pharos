// type for special constructors
struct special_constructor {};
struct abstract_0 { int x; };
struct abstract_1 { int x; };
struct abstract_2 { int x; };
struct abstract_3 { int x; };
struct abstract_4 { int x; };
struct abstract_5 { int x; };
struct C0;

struct C1;

struct C2;

struct C3;

struct C0  {
/* method id 400 */ ~C0 ();
/* method id 401 */ abstract_0 func1 ();
C0 (special_constructor);
};
struct C1  {
/* method id 403 */ abstract_1 func3 ();
/* method id 404 */ abstract_2 func4 ();
/* method id 405 */ C1 ();
/* method id 406 */ ~C1 ();
C1 (special_constructor);
};
struct C2  {
/* method id 407 */ ~C2 ();
C2 (special_constructor);
};
struct C3 : public C0, public C1 {
/* method id 409 */ abstract_3 func9 ();
/* method id 410 */ abstract_4 func10 ();
/* method id 411 */ ~C3 ();
/* method id 412 */ abstract_5 func12 ();
C3 (special_constructor);
};
// definitions
/* method id 400 */ C0::~C0 () {
delete 0;
return;

}
/* method id 401 */ abstract_0 C0::func1 () {
delete 0;
return abstract_0();

}
C0::C0 (special_constructor)  {}

/* method id 403 */ abstract_1 C1::func3 () {
return abstract_1();

}
/* method id 404 */ abstract_2 C1::func4 () {
return abstract_2();

}
/* method id 405 */ C1::C1 () {
return;

}
/* method id 406 */ C1::~C1 () {
return;

}
C1::C1 (special_constructor)  {}

/* method id 407 */ C2::~C2 () {
delete 0;
return;

}
C2::C2 (special_constructor)  {}

/* method id 409 */ abstract_3 C3::func9 () {
return abstract_3();

}
/* method id 410 */ abstract_4 C3::func10 () {
return abstract_4();

}
/* method id 411 */ C3::~C3 () {
return;

}
/* method id 412 */ abstract_5 C3::func12 () {
return abstract_5();

}
C3::C3 (special_constructor) : C0(special_constructor ()), C1(special_constructor ()) {}

#include <iostream>
void check_driver() {
/*
class C0    size(0)
0    +---
0    +---
*/
{
 const C0* obj = new C0(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C0);
 const size_t layout_size = 1;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C0 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C0 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
}
/*
class C1    size(0)
0    +---
0    +---
*/
{
 const C1* obj = new C1(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C1);
 const size_t layout_size = 1;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C1 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C1 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
}
/*
class C2    size(0)
0    +---
0    +---
*/
{
 const C2* obj = new C2(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C2);
 const size_t layout_size = 1;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C2 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C2 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
}
/*
class C3    size(1)
0    +---
0    | +--- (base class C0)
0    | +---
0    | +--- (base class C1)
0    | +---
1    +---
*/
{
 const C3* obj = new C3(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C3);
 const size_t layout_size = 1;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C3 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C3 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
 {
 const C0* baseobj = (C0*) obj;
 const size_t computed_offset = (uintptr_t)baseobj - (uintptr_t)obj;
 const size_t model_offset = 0;
 if (computed_offset == model_offset) {
  std::cerr << "BASEOFFSET CORRECT: C3 C0 " << computed_offset << std::endl;
 } else {
  const size_t vc_base_size = sizeof(C0);
  if (vc_base_size == 0 || vc_base_size == 1) std::cerr << "BASEOFFSET WEIRD: C3 C0 ";
  else std::cerr << "BASEOFFSET INCORRECT: C3 C0 ";
  std::cerr << computed_offset << " " << model_offset << std::endl;
 }} {
 const C1* baseobj = (C1*) obj;
 const size_t computed_offset = (uintptr_t)baseobj - (uintptr_t)obj;
 const size_t model_offset = 0;
 if (computed_offset == model_offset) {
  std::cerr << "BASEOFFSET CORRECT: C3 C1 " << computed_offset << std::endl;
 } else {
  const size_t vc_base_size = sizeof(C1);
  if (vc_base_size == 0 || vc_base_size == 1) std::cerr << "BASEOFFSET WEIRD: C3 C1 ";
  else std::cerr << "BASEOFFSET INCORRECT: C3 C1 ";
  std::cerr << computed_offset << " " << model_offset << std::endl;
 }}}
}
int main() { check_driver (); }
