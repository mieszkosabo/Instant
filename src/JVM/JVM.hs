module Main where

import Control.Monad.State
import qualified Data.Map as Map
import Frontend.AbsInstant
import Frontend.Frontend (parseFile)
import Src.JVM.GenerateCode.GenerateCode
import Src.JVM.Types
import System.Environment (getArgs, getProgName)

f :: [String] -> Stmt -> JVMIC [String]
f acc stmt = do
  code <- generateCodeStmt stmt
  return $ acc ++ code

execStmts = foldM f []

runJVMIC :: [Stmt] -> [String]
runJVMIC stmts = evalState (execStmts stmts) Map.empty

main :: IO ()
main = do
  files <- getArgs
  (Prog stmts) <- parseFile $ head files
  print $ runJVMIC stmts
