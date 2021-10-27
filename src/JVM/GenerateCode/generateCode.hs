module Src.JVM.GenerateCode.GenerateCode where

import Frontend.AbsInstant
import Src.JVM.RequiredStackSize.RequiredStackSize (requiredStackSize)
import Src.JVM.Types
import Src.JVM.Utils.Utils as Utils
import Src.Shared.Types

generateCodeExp :: Exp -> JVMIC Code
generateCodeExp (ExpAdd e e') = do
  code' <- generateCodeExp e'
  code <- generateCodeExp e
  return $ code' ++ code ++ ["iadd"]
generateCodeExp (ExpLit n) = return [push n]
generateCodeExp (ExpSub e e') = do
  code <- generateCodeExp e
  code' <- generateCodeExp e'
  return $ code ++ code' ++ ["isub"]
generateCodeExp (ExpDiv e e') = do
  code <- generateCodeExp e
  code' <- generateCodeExp e'
  return $ code ++ code' ++ ["idiv"]
generateCodeExp (ExpMul e e') = do
  let reqSize = requiredStackSize e
  let reqSize' = requiredStackSize e'
  code <- generateCodeExp e
  code' <- generateCodeExp e'
  if reqSize < reqSize'
    then return $ code ++ code' ++ ["imul"]
    else return $ code' ++ code ++ ["imul"]
generateCodeExp (ExpVar (Ident ident)) = do
  idx <- Utils.lookup ident
  if idx == -1
    then return [push 0] -- converting undeclared variables to 0s
    else return [load idx]

generateCodeStmt :: Stmt -> JVMIC Code
-- evaluate expr and print its value
generateCodeStmt (SExp e) = do
  code <- generateCodeExp e
  return $
    ["getstatic java/lang/System/out Ljava/io/PrintStream;"]
      ++ code
      ++ ["invokevirtual java/io/PrintStream/println(I)V"]
generateCodeStmt (SAss (Ident ident) e) = do
  code <- generateCodeExp e
  idx <- Utils.assign ident
  return $ code ++ [store idx]