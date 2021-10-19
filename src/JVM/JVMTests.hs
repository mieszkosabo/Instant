import Test.HUnit

add :: Int -> Int -> Int
add a b = a + b

test1 = TestCase (assertEqual "adds 2 and 3" 5 (add 2 3))

tests = TestList [TestLabel "tst" test1]
