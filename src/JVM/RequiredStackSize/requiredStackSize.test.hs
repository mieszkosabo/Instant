import Test.HUnit
import Frontend.AbsInstant

import Src.JVM.RequiredStackSize.RequiredStackSize

test1 = TestCase (
    assertEqual 
    "Calculates required stack size for test 1" 
    3
    $ requiredStackSize (ExpAdd (ExpMul (ExpLit 2) (ExpLit 3)) (ExpAdd (ExpLit 1) (ExpAdd (ExpLit 1) (ExpMul (ExpLit 1) (ExpLit 5)))))
    )

test2 = TestCase (
    assertEqual
    "Calculates required stack size for test 2"
    2
    $ requiredStackSize (ExpAdd (ExpLit 1) (ExpAdd (ExpLit 2) (ExpAdd (ExpLit 3) (ExpLit 4))))
    )

test3 = TestCase (
    assertEqual
    "Calculates required stack size for test 3"
    4
    $ requiredStackSize (ExpAdd (ExpSub (ExpSub (ExpLit 5) (ExpMul (ExpLit 2) (ExpLit 3))) (ExpLit 1)) (ExpLit 4))
    )

tests = TestList [
    TestLabel "Test 1" test1, 
    TestLabel "Test 2" test2,
    TestLabel "Test 3" test3
    ]

-- in ghci run "runTestTT tests" to see run tests