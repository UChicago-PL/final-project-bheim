module Metrics where
import Types
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Data.List (sortBy)

degree:: Graph -> NoteName -> Int
-- returns number of connections a note has
degree g n = case Map.lookup n g of
    Nothing -> 0
    Just c -> Set.size c

mostConnected :: Graph -> Int -> [NoteName]
-- gives n most connected notes
mostConnected g n =
    let n_list = Map.toList g
        n_conn_list = map(\(name, c) -> (name, Set.size c)) n_list
        sorted_conn_list = sortBy (\(_, a) (_, b) -> compare b a) n_conn_list
    in map fst (take n sorted_conn_list)

numNodes :: Graph -> Int
numNodes g = Map.size g

numEdges:: Graph -> Int
-- divide by two since edges are double counted
numEdges g = Map.foldl' (\acc value -> acc + Set.size value) 0 g `div` 2

averageDegree:: Graph -> Double
averageDegree g = fromIntegral (numEdges g * 2) / fromIntegral (numNodes g)

isolatedNodes:: Graph -> [NoteName]
isolatedNodes g = Map.keys $ Map.filter (\value -> Set.size value == 0) g