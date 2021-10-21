module Src.Shared.Utils where
import Data.Text (pack, replace, unpack)

getDirectoryFromFilepath :: String -> String
getDirectoryFromFilepath filepath = if result == "" then "." else result
    where result = reverse . dropWhile (/= '/') . reverse $ filepath
    
replaceFileExtension :: String -> String -> String -> String
replaceFileExtension oldExt newExt filename 
    = unpack (replace (pack oldExt) (pack newExt) (pack filename))