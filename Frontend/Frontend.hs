module Main where

import AbsInstant
import ErrM
import ParInstant (myLexer, pProgram)
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure, exitSuccess)
import System.IO (getContents, hGetContents, hPutStr, hPutStrLn, stderr, stdin)

parse :: String -> IO ()
parse input =
  case pProgram (myLexer input) of
    (Ok parsedProg) -> do
      print parsedProg
    (Bad msg) -> hPutStrLn stderr msg >> exitFailure

parseFile :: String -> IO ()
parseFile filename = readFile filename >>= parse

main :: IO ()
main = do
  files <- getArgs
  parseFile $ head files