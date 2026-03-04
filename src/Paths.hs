module Paths where
import Types
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

bfs :: Graph -> NoteName -> Set.Set NoteName
bfs g start = go [start] (Set.singleton start)
    where
        go [] visited = visited
        go (x:next) visited =
            let ns = case Map.lookup x g of
                        Nothing -> Set.empty
                        Just set -> set
            in go (Set.toList (Set.difference ns visited) ++ next) (Set.union ns visited)

shortestPath :: Graph -> NoteName -> NoteName -> Maybe [NoteName]
shortestPath g start end = go [start] end (Set.singleton start) Map.empty
    where
    go [] _ _ _ = Nothing
    go (x:next) end visited m =
        if Set.member end visited
        then uncoverPath end start m
        else let ns = case Map.lookup x g of
                        Nothing -> Set.empty
                        Just set -> set
                 new = Set.difference ns visited
                 m' = Set.foldl' (\acc neighbor -> Map.insert neighbor x acc) m new
            in go (Set.toList new ++ next) end (Set.union ns visited) m'


distanceFrom :: Graph -> NoteName -> NoteName -> Maybe Int
distanceFrom g start end = fmap length (shortestPath g start end)


uncoverPath :: NoteName -> NoteName -> Map NoteName NoteName -> Maybe [NoteName]
uncoverPath current end m =
    if current == end
        then Just [end]
        else case Map.lookup current m of
                    Nothing -> Nothing
                    Just p -> fmap (current:) (uncoverPath p end m)