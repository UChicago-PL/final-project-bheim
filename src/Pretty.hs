module Pretty where
import Types
import Metrics
import Neighbors
import Paths

printMetrics :: Graph -> IO ()
printMetrics g = do
    putStrLn ("Number of nodes: " ++ show (numNodes g))
    putStrLn ("Number of edges: " ++ show (numEdges g))
    putStrLn ("Average degree: " ++ show(averageDegree g))
    putStrLn ("Most connected Node " ++  show((mostConnected g 1) !! 0))

printTopConn :: Graph -> Int -> IO ()
printTopConn g n = do
    putStrLn ("Most connected nodes are:" ++ concatMap (\a -> " " ++ a) (mostConnected g n))
    putStrLn ("Isolated nodes are:" ++ concatMap (\a -> " " ++ a) (isolatedNodes g))

printSuggestions :: Graph -> Int -> IO ()
printSuggestions g n = do
    putStrLn ("Your top suggestions are:")
    putStrLn  (concatMap(\t -> tNoteA t ++ " and " ++ tNoteB t ++ " through " ++ show (tCommon t)) (topSuggestions g n))

printPath :: Graph -> NoteName -> NoteName -> IO ()
printPath g start end  = do
    let path = shortestPath g start end
    case path of
        Nothing -> putStrLn "No path found"
        Just p -> putStrLn ("The path is:" ++ concatMap(\n -> n ++ " ") p)