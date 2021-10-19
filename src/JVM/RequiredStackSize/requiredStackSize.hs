module Src.JVM.RequiredStackSize.RequiredStackSize where
import Frontend.AbsInstant

requiredStackSize :: Exp -> Int
-- notice that ExpAdd evaluates e' first, so e and e' are flipped
requiredStackSize (ExpAdd e e') = max (requiredStackSize e') (requiredStackSize e + 1)
requiredStackSize (ExpDiv e e') = max (requiredStackSize e) (requiredStackSize e' + 1)
requiredStackSize (ExpSub e e') = max (requiredStackSize e) (requiredStackSize e' + 1)

-- here we can choose which expr to evaluate first, so we choose the one that requires
-- less stack space first
requiredStackSize (ExpMul e e') = if req /= req' then max req req' else req + 1
    where req = requiredStackSize e
          req' = requiredStackSize e'

requiredStackSize (ExpLit _) = 1
requiredStackSize (ExpVar _) = 1

requiredStackSizeStmt :: Stmt -> Int
requiredStackSizeStmt (SAss _ e) = requiredStackSize e
requiredStackSizeStmt (SExp e) = requiredStackSize e

requiredStackSizeForProgram :: [Stmt] -> Int
requiredStackSizeForProgram = (foldr max 0) . (map requiredStackSizeStmt)


