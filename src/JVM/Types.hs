module Src.JVM.Types where

import Control.Monad.State
import qualified Data.Map as M

type Store = M.Map String Integer

type JVMIC a = State Store a
