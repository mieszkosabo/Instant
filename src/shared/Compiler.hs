module Src.Shared.Compiler where

import Frontend.AbsInstant

class InstantCompiler a where
  generateCode :: a -> [Stmt] -> String
