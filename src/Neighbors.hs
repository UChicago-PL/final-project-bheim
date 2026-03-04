module Neighbors where
import Types
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Data.List (sortBy)

neighbors:: Graph -> NoteName -> Set.Set NoteName
neighbors g name = case Map.lookup name g of
    Nothing -> Set.empty
    Just ns -> ns

commonNeighbors:: Graph -> NoteName -> NoteName -> Set.Set NoteName
commonNeighbors g n1 n2 =
    let n1s = neighbors g n1
        n2s = neighbors g n2
    in Set.intersection n1s n2s

openTriangles:: Graph -> [Triangle]
-- A triangle has at least one common neighbor
openTriangles g =
    [Triangle a b common
    | a <- Map.keys g
    , b <- Map.keys g
    , a < b
    , not (Set.member b (neighbors g a))
    , let common = Set.toList (commonNeighbors g a b)
    , not (null common)]

topSuggestions:: Graph -> Int -> [Triangle]
topSuggestions g n=
    let ts = openTriangles g
    in take n (sortBy(\a b -> compare (length(tCommon b)) (length(tCommon a))) ts)