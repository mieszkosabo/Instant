module Frontend.Frontend where

import Frontend.AbsInstant
import Frontend.ErrM
import Frontend.ParInstant (myLexer, pProgram)
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure, exitSuccess)
import System.IO (getContents, hGetContents, hPutStr, hPutStrLn, stderr, stdin)

parse :: String -> IO Program
parse input =
  case pProgram (myLexer input) of
    (Ok parsedProg) -> return parsedProg
    (Bad msg) -> hPutStrLn stderr msg >> exitFailure

parseFile :: String -> IO Program
parseFile filename = readFile filename >>= parse

main :: IO Program
main = do
  files <- getArgs
  parseFile $ head files