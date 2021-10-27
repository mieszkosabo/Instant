module Src.Shared.Utils where

import Control.Monad.State
import Data.Text (pack, replace, unpack)

getDirectoryFromFilepath :: String -> String
getDirectoryFromFilepath filepath = if result == "" then "." else result
  where
    result = reverse . dropWhile (/= '/') . reverse $ filepath

getFilenameFromFilepath :: String -> String
getFilenameFromFilepath = reverse . takeWhile (/= '/') . reverse

replaceFileExtension :: String -> String -> String -> String
replaceFileExtension oldExt newExt filename =
  unpack (replace (pack oldExt) (pack newExt) (pack filename))

removeExtension :: String -> String
removeExtension filepath = reverse . tail . dropWhile (/= '.') . reverse $ filename
  where
    filename = getFilenameFromFilepath filepath

execStmts generateCodeStmt = foldM f []
  where
    f acc stmt = do
      code <- generateCodeStmt stmt
      return $ acc ++ code