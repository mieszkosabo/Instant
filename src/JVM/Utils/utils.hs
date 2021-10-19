module Src.JVM.Utils.Utils where

import Control.Monad.State
import Data.Map as M
import Src.JVM.Types

max_16_bit_signed_int = 32767

max_8_bit_signed_int = 127

-- in Instant we deal only with non negative integer constants
push :: Integer -> String
push n
  | n <= 5 = "iconst_" ++ show n
  | n <= max_8_bit_signed_int = "bipush " ++ show n
  | n <= max_16_bit_signed_int = "sipush " ++ show n
  | otherwise = "ldc " ++ show n

loadOrStore :: String -> Integer -> String
loadOrStore cmd n
  | n <= 3 = cmd ++ ('_' : show n)
  | otherwise = cmd ++ (' ' : show n)

load :: Integer -> String
load = loadOrStore "iload"

store :: Integer -> String
store = loadOrStore "istore"

-- in contrary to an interpreter, here the resulting integer
-- is a local variable index
lookup :: String -> JVMIC Integer
lookup ident = do
  state <- get
  case M.lookup ident state of
    Just idx -> return idx
    -- let's mark that this variable was not declared
    -- and deal with it in GenerateCode module
    Nothing -> return $ -1

assign :: String -> JVMIC Integer
assign ident = do
  state <- get
  case M.lookup ident state of
    -- reassign
    Just idx -> return idx
    -- new variable
    Nothing -> do
      let newIdx = toInteger $ M.size state
      put $ M.insert ident newIdx state
      return newIdx