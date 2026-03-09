module Main where
import System.Environment (getArgs)
import Types
import Parser
import GraphBuilder
import Metrics
import Neighbors
import Paths
import Pretty
import Visualization

main :: IO ()
main = do
    args <- getArgs
    let vault = head args
    notes <- parseVault vault
    let g = makeUndirected (buildGraph notes)
    printMetrics g
    printTopConn g 3
    printSuggestions g 3
    putStrLn "Provide the names of two notes to see the shortest path between them.\n Enter first note:"
    n1 <- getLine
    putStrLn("Enter second note:")
    n2 <- getLine
    printPath g n1 n2
    putStrLn("Now exporting your visualization")
    exportDot "graph.dot" (toDot g)
    renderGraph "graph.dot"  "graph.png"
