import Control.Monad.State
import qualified Data.Map as M
import Frontend.AbsInstant
import Frontend.Frontend (parseFile)
import Src.LLVM.GenerateCode.GenerateCode
import Src.LLVM.Types
import Src.Shared.Utils
import System.Environment (getArgs, getProgName)
import System.Process (callCommand)

writeLLVMFile :: String -> String
writeLLVMFile cmds =
  "declare void @printInt(i32)\n"
    ++ "define i32 @main(){\n"
    ++ cmds
    ++ "ret i32 0\n"
    ++ "}\n"

runLLVMIC :: [Stmt] -> ([String], Store)
runLLVMIC stmts = runState (execStmts generateCodeStmt stmts) ([1 ..], M.empty)

main :: IO ()
main = do
  files <- getArgs
  (Prog stmts) <- parseFile $ head files
  let (cmdsList, _) = runLLVMIC stmts
  let cmds = unlines cmdsList
  let newFilename = replaceFileExtension ".ins" ".ll" $ head files
  let bytecodeFilename = replaceFileExtension ".ll" ".bc" newFilename
  writeFile newFilename $ writeLLVMFile cmds
  callCommand $ "llvm-as -o " ++ bytecodeFilename ++ " " ++ newFilename
  callCommand $ "llvm-link -o " ++ bytecodeFilename ++ " " ++ bytecodeFilename ++ " lib/runtime.bc"
