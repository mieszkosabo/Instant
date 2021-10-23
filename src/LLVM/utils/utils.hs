module Src.LLVM.Utils.Utils where

import Control.Monad.State
import Data.Map as M
import Src.LLVM.Types
import Src.Shared.Types

getFreshId :: LLVMIC String
getFreshId = do
  (stream, store) <- get
  let nextNum = head stream
  put (tail stream, store)
  return $ "%t" ++ show nextNum

lookup :: Id -> LLVMIC (Address, Code)
lookup ident = do
  (_, store) <- get
  case M.lookup ident store of
    Just addr -> return (addr, [])
    Nothing -> do
      addr <- getFreshId
      let code = [addr ++ " = alloca i32", "store i32 0, i32* " ++ addr]
      return (addr, code)
