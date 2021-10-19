module Src.JVM.Utils.Utils where

max_16_bit_signed_int = 32767
max_8_bit_signed_int  = 127

-- in Instant we deal only with non negative integer constants
push :: Integer -> String
push n
    | n <= 5                     = concat ["iconst_", show n]
    | n <= max_8_bit_signed_int  = concat ["bipush ", show n]
    | n <= max_16_bit_signed_int = concat ["sipush ", show n]
    | otherwise                  = concat ["ldc ", show n]

loadOrStore :: String -> Integer -> String
loadOrStore cmd n
    | n <= 3 = concat [cmd, '_':show n]
    | otherwise = concat [cmd, ' ':show n]

load :: Integer -> String
load = loadOrStore "iload"

store :: Integer -> String
store = loadOrStore "istore"