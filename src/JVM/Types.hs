module Src.JVM.Types where

import qualified Data.Map as M
import Control.Monad.State

type Store = M.Map String Integer

type JVMIC a = State Store a
