module Parser where
import Types
import System.Directory (listDirectory)
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
        files <- listDirectory dir
        let mds = filter(\f -> takeExtension f == ".md") files
        mapM parseFile (map (dir </>) mds)