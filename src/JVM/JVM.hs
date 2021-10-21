module Main where

import Control.Monad.State
import qualified Data.Map as Map
import Frontend.AbsInstant
import Frontend.Frontend (parseFile)
import Src.JVM.GenerateCode.GenerateCode
import Src.JVM.RequiredStackSize.RequiredStackSize (requiredStackSizeForProgram)
import Src.JVM.Types
import Src.Shared.Utils
import Src.Shared.Compiler
import System.Environment (getArgs, getProgName)
import System.Process (callCommand)

f :: [String] -> Stmt -> JVMIC [String]
f acc stmt = do
  code <- generateCodeStmt stmt
  return $ acc ++ code

execStmts = foldM f []

runJVMIC :: [Stmt] -> ([String], Store)
runJVMIC stmts = runState (execStmts stmts) Map.empty

writeJVMFile :: String -> Int -> Int -> String
writeJVMFile cmds stackLimit localsLimit =
  ".class public Program\n"
    ++ ".super java/lang/Object\n\n"
    ++ ".method public <init>()V\n"
    ++ "aload_0\n"
    ++ "invokespecial java/lang/Object/<init>()V\n"
    ++ "return\n"
    ++ ".end method\n\n"
    ++ ".method public static main([Ljava/lang/String;)V\n"
    ++ ".limit stack " 
    ++ show stackLimit
    ++ "\n"
    ++ (if localsLimit > 0 then ".limit locals " ++ show localsLimit ++ "\n" else "")
    ++ cmds
    ++ "return\n"
    ++ ".end method\n"

main :: IO ()
main = do
  files <- getArgs
  (Prog stmts) <- parseFile $ head files
  let (cmdsList, store) = runJVMIC stmts
  let cmds = unlines cmdsList
  let stackLimit = requiredStackSizeForProgram stmts
  let localsLimit = Map.size store
  let newFilename = replaceFileExtension ".ins" ".j" $ head files
  writeFile newFilename $ writeJVMFile cmds stackLimit localsLimit
  callCommand $ "java -jar lib/jasmin.jar " ++ newFilename ++ " -d " ++ getDirectoryFromFilepath newFilename
