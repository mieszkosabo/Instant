import Src.Shared.Utils
import Test.HUnit

t1 =
  TestCase
    ( assertEqual
        "gets directory from regular path"
        "ala/ma/"
        $ getDirectoryFromFilepath "ala/ma/kota.hs"
    )

t2 =
  TestCase
    ( assertEqual
        "gets current directory (.) when just filename is provided"
        "."
        $ getDirectoryFromFilepath "kota.hs"
    )

t3 =
  TestCase
    ( assertEqual
        "removes extension from a file without full path"
        "ala"
        $ removeExtension "ala.ma"
    )

t4 =
  TestCase
    ( assertEqual
        "removes extension from a file with some path"
        "ma"
        $ removeExtension "ala/ma.kota"
    )

tests =
  TestList
    [ TestLabel "Test 1" t1,
      TestLabel "Test 2" t2,
      TestLabel "Test 3" t3,
      TestLabel "Test 4" t4
    ]

main = runTestTT tests