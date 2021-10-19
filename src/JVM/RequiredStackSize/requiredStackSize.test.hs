import Test.HUnit
import Frontend.AbsInstant

import Src.JVM.RequiredStackSize.RequiredStackSize

e1 = (ExpAdd (ExpMul (ExpLit 2) (ExpLit 3)) (ExpAdd (ExpLit 1) (ExpAdd (ExpLit 1) (ExpMul (ExpLit 1) (ExpLit 5)))))
test1 = TestCase (
    assertEqual 
    "Calculates required stack size for test 1" 
    3
    $ requiredStackSize e1
    )

e2 = (ExpAdd (ExpLit 1) (ExpAdd (ExpLit 2) (ExpAdd (ExpLit 3) (ExpLit 4))))
test2 = TestCase (
    assertEqual
    "Calculates required stack size for test 2"
    2
    $ requiredStackSize e2
    )

e3 = (ExpAdd (ExpSub (ExpSub (ExpLit 5) (ExpMul (ExpLit 2) (ExpLit 3))) (ExpLit 1)) (ExpLit 4))
test3 = TestCase (
    assertEqual
    "Calculates required stack size for test 3"
    4
    $ requiredStackSize e3
    )

totalRequiredStackSizeTest = TestCase (
    assertEqual
    "Calculates required stack size for a list of statements"
    4
    $ requiredStackSizeForProgram [
            SExp e1,
            SExp e3,
            SExp e2
        ]
    )

tests = TestList [
    TestLabel "Test 1" test1, 
    TestLabel "Test 2" test2,
    TestLabel "Test 3" test3,
    TestLabel "Test 4" totalRequiredStackSizeTest
    ]

-- in ghci run "runTestTT tests" to see run tests