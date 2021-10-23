module Src.LLVM.GenerateCode.GenerateCode where

import Frontend.AbsInstant
import Src.LLVM.Types
import Src.LLVM.Utils.Utils as Utils
import Src.Shared.Types

generateCodeExp :: Exp -> LLVMIC (Address, Code)
generateCodeExp (ExpAdd e e') = do
  (res, code) <- generateCodeExp e'
  (res', code') <- generateCodeExp e
  newId <- getFreshId
  return (newId, code ++ code' ++ [newId ++ " = add i32 " ++ res ++ ", " ++ res'])
generateCodeExp (ExpSub e e') = do
  (res, code) <- generateCodeExp e
  (res', code') <- generateCodeExp e'
  newId <- getFreshId
  return (newId, code ++ code' ++ [newId ++ " = sub i32 " ++ res ++ ", " ++ res'])
generateCodeExp (ExpDiv e e') = do
  (res, code) <- generateCodeExp e
  (res', code') <- generateCodeExp e'
  newId <- getFreshId
  return (newId, code ++ code' ++ [newId ++ " = div i32 " ++ res ++ ", " ++ res'])
generateCodeExp (ExpMul e e') = do
  (res, code) <- generateCodeExp e
  (res', code') <- generateCodeExp e'
  newId <- getFreshId
  return (newId, code ++ code' ++ [newId ++ " = mul i32 " ++ res ++ ", " ++ res'])
generateCodeExp (ExpLit n) = return (show n, [])
generateCodeExp (ExpVar (Ident ident)) = do
  (addr, code) <- Utils.lookup ident False
  newId <- getFreshId
  return (newId, code ++ [newId ++ " = load i32, i32* " ++ addr])

generateCodeStmt :: Stmt -> LLVMIC Code
generateCodeStmt (SExp e) = do
  (res, code) <- generateCodeExp e
  return $ code ++ ["call void @printInt(i32 " ++ res ++ ")"]
generateCodeStmt (SAss (Ident ident) e) = do
  (res, code) <- generateCodeExp e
  (addr, code') <- Utils.lookup ident True
  return $ code ++ code' ++ ["store i32 " ++ res ++ ", i32* " ++ addr]
