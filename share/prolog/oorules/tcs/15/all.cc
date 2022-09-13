// type for special constructors
struct special_constructor {};
struct abstract_1 { int x; };
struct abstract_2 { int x; };
struct abstract_0 { int x; };
struct abstract_3 { int x; };
struct C0;

struct C1;

struct C2;

struct C0  {
/* method id 400 */ abstract_1 func0 (abstract_0 v0);
/* method id 401 */ abstract_2 func1 ();
/* method id 402 */ C0 ();
/* method id 403 */ virtual ~C0 ();
C0 (special_constructor);
abstract_3 v1;
};
struct C1 : public virtual C0 {
/* method id 404 */ C1 ();
/* method id 405 */ ~C1 ();
C1 (special_constructor);
};
struct C2 : public C0 {
/* method id 406 */ ~C2 ();
/* method id 407 */ C2 ();
C2 (special_constructor);
C1 v2;
};
// definitions
/* method id 400 */ abstract_1 C0::func0 (abstract_0 v0) {
return abstract_1();

}
/* method id 401 */ abstract_2 C0::func1 () {
return abstract_2();

}
/* method id 402 */ C0::C0 () {
return;

}
/* method id 403 */ C0::~C0 () {
return;

}
C0::C0 (special_constructor)  {}

/* method id 404 */ C1::C1 () {

}
/* method id 405 */ C1::~C1 () {

}
C1::C1 (special_constructor) : C0(special_constructor ()) {}

/* method id 406 */ C2::~C2 () {
return;

}
/* method id 407 */ C2::C2 () {

}
C2::C2 (special_constructor) : C0(special_constructor ()) {}

#include <iostream>
void check_driver() {
/*
class C0    size(8)
0    +---
0    | {vfptr}
4    | var1: AbstractType{3}
8    +---
*/
{
 const C0* obj = new C0(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C0);
 const size_t layout_size = 8;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C0 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C0 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
}
/*
class C1    size(12)
0    +---
0    | {vbptr}
4    +---
4    +--- (virtual base class C0)
4    | {vfptr}
8    | var1: AbstractType{3}
12   +---
*/
{
 const C1* obj = new C1(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C1);
 const size_t layout_size = 12;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C1 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C1 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
 {
 const C0* baseobj = (C0*) obj;
 const size_t computed_offset = (uintptr_t)baseobj - (uintptr_t)obj;
 const size_t model_offset = 4;
 if (computed_offset == model_offset) {
  std::cerr << "BASEOFFSET CORRECT: C1 C0 " << computed_offset << std::endl;
 } else {
  const size_t vc_base_size = sizeof(C0);
  if (vc_base_size == 0 || vc_base_size == 1) std::cerr << "BASEOFFSET WEIRD: C1 C0 ";
  else std::cerr << "BASEOFFSET INCORRECT: C1 C0 ";
  std::cerr << computed_offset << " " << model_offset << std::endl;
 }}}
/*
class C2    size(20)
0    +---
0    | +--- (base class C0)
0    | | {vfptr}
4    | | var1: AbstractType{3}
8    | +---
8    | var2: ClassType{1}
20   +---
*/
{
 const C2* obj = new C2(special_constructor());
 // verify class size
 const size_t vc_size = sizeof(C2);
 const size_t layout_size = 20;
 if (vc_size == layout_size) {
  std::cerr << "CLASSSIZE CORRECT: C2 " << layout_size << std::endl;
 } else {
  std::cerr << "CLASSSIZE INCORRECT: C2 " << vc_size << " " << layout_size << std::endl;
 }
 // verify base offset
 {
 const C0* baseobj = (C0*) obj;
 const size_t computed_offset = (uintptr_t)baseobj - (uintptr_t)obj;
 const size_t model_offset = 0;
 if (computed_offset == model_offset) {
  std::cerr << "BASEOFFSET CORRECT: C2 C0 " << computed_offset << std::endl;
 } else {
  const size_t vc_base_size = sizeof(C0);
  if (vc_base_size == 0 || vc_base_size == 1) std::cerr << "BASEOFFSET WEIRD: C2 C0 ";
  else std::cerr << "BASEOFFSET INCORRECT: C2 C0 ";
  std::cerr << computed_offset << " " << model_offset << std::endl;
 }}}
}
int main() { check_driver (); }
