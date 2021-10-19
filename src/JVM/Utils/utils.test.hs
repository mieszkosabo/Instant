import Test.HUnit

import Src.JVM.Utils.Utils


pushTest1 = TestCase (
    assertEqual 
    "n <= 5" 
    "iconst_5"
    $ push 5
    )

pushTest2 = TestCase (
    assertEqual 
    "n is 8 bit" 
    "bipush 6"
    $ push 6
    )

pushTest3 = TestCase (
    assertEqual 
    "n is 16 bit" 
    "sipush 32767"
    $ push 32767
    )

pushTest4 = TestCase (
    assertEqual 
    "n is large" 
    "ldc 32768"
    $ push 32768
    )

loadTest1 = TestCase (
    assertEqual 
    "n == 3" 
    "iload_3"
    $ load 3
    )

storeTest1 = TestCase (
    assertEqual 
    "n == 4" 
    "istore 4"
    $ store 4
    )

tests = TestList [
    TestLabel "push test 1" pushTest1,
    TestLabel "push test 2" pushTest2,
    TestLabel "push test 3" pushTest3,
    TestLabel "push test 4" pushTest4,
    TestLabel "load test 1" loadTest1,
    TestLabel "store test 1" storeTest1
    ]