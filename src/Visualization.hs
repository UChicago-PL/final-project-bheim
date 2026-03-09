module Visualization where
import Types
import Neighbors
import Paths
import System.Process (callCommand)
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

toDot :: Graph -> String
-- takes graph and formats it in .dot so it can be visualized
toDot g = "graph Vault {\n  layout=neato;\n  overlap=false;\n  splines=true;\n" ++
    unlines [" \"" ++ a ++ "\" -- \"" ++ b ++ "\""
            | a <- Map.keys g
            , b <- Set.toList (neighbors g a)
            , a < b] -- ensures no double counting
    ++ "}"

toDotHighlight :: Graph -> [NoteName] ->String
toDotHighlight g h = "graph Vault {\n" ++
    unlines [ if elem a h
            then "  \"" ++ a ++ "\" [color=red, style=filled, fillcolor=red, fontcolor=white]"
            else "  \"" ++ a ++ "\""
            | a <- Map.keys g
            ] ++
    unlines [" \"" ++ a ++ "\" -- \"" ++ b ++ "\""
            | a <- Map.keys g
            , b <- Set.toList (neighbors g a)
            , a < b] -- ensures no double counting
    ++ "\n}"

exportDot :: FilePath -> String -> IO()
exportDot path s = writeFile path s

renderGraph :: FilePath -> FilePath -> IO ()
renderGraph df png = callCommand ("dot -Tpng " ++ df ++ " -o " ++ png)