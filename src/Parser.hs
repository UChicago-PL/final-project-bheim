module Parser where
import Types
import Control.Monad
import System.Directory (listDirectory, doesDirectoryExist, doesFileExist)
import System.FilePath (takeBaseName, takeExtension, (</>))
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

parseLinks :: String -> [NoteName]
parseLinks [] = []
parseLinks ('[':'[':rest) = go "" rest
    where
    go :: String -> String -> [NoteName]
    go s [] = []
    go s (']':']':rest) = s : parseLinks rest
    go s (a:rest) = go (s++[a]) rest
parseLinks (_:rest) = parseLinks rest

parseFile:: FilePath -> IO Note
parseFile path = do
    content <- readFile path
    let name = takeBaseName path
        links = parseLinks content
    return Note { name = name, content = content, noteLinks = links}

parseVault :: FilePath -> IO [Note]
parseVault dir = do
        mdFiles <- findMdFiles dir
        mapM parseFile mdFiles

findMdFiles :: FilePath -> IO [FilePath]
findMdFiles dir = do
    contents <- listDirectory dir
    let fullPaths = map (dir </>) contents
    files <- filterM doesFileExist fullPaths -- checks if it's a file or directory
    dirs <- filterM doesDirectoryExist fullPaths
    let mdFiles = filter(\f -> takeExtension f == ".md") files
    subFiles <- mapM findMdFiles dirs -- recursive call to get all files
    return (mdFiles ++ concat subFiles)