# Instant Compiler

## TODOS:

- create function in shared/utils that infers directory to output .class, .j, etc files from
  pathname
- create Compile Class in shared/compile so that JVM and LLVM compilers can be instances of
  this class so that we minimize redundant code
- change directories from PascalCase to camelCase
- implement LLVM as instance of compiler