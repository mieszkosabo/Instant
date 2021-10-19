module Main where

import Frontend.Frontend (parseFile)
import System.Environment (getArgs, getProgName)

main :: IO ()
main = do
  files <- getArgs
  stmts <- parseFile $ head files
  print stmts
