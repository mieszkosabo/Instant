import Test.HUnit
import Src.Shared.Utils

-- getDirectoryFromFilepath tests

t1 = TestCase (
    assertEqual
    "gets directory from regular path"
    "ala/ma/"
    $ getDirectoryFromFilepath "ala/ma/kota.hs"
    )

t2 = TestCase (
    assertEqual
    "gets current directory (.) when just filename is provided"
    "."
    $ getDirectoryFromFilepath "kota.hs"
    )

tests = TestList [
    TestLabel "Test 1" t1,
    TestLabel "Test 2" t2
    ]

main = runTestTT tests