module Src.JVM.GenerateCode.GenerateCode where

import Frontend.AbsInstant
import Src.JVM.RequiredStackSize.RequiredStackSize (requiredStackSize)
import Src.JVM.Types
import Src.JVM.Utils.Utils

generateCodeExp :: Exp -> JVMIC [String]
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

-- TODO
generateCodeExp (ExpVar ident) = undefined

generateCodeStmt :: Stmt -> JVMIC [String]
-- evaluate expr and print its value
generateCodeStmt (SExp e) = do
  code <- generateCodeExp e
  return $
    code
      ++ [ "getstatic java/lang/System/out Ljava/io/PrintStream;",
           "invokevirtual java/io/PrintStream/println(I)V"
         ]
-- TODO
generateCodeStmt (SAss ident e) = undefined