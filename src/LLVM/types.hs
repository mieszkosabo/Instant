module Src.LLVM.Types where

import Control.Monad.State
import Data.Map as M

type Store = ([Integer], M.Map String String)

type LLVMIC a = State Store a