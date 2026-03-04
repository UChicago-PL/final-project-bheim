module GraphBuilder  where
import Types
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

buildGraph :: [Note] -> Graph
buildGraph [] = Map.empty
buildGraph (n:ns) = Map.unionWith Set.union (Map.singleton (name n) (Set.fromList (noteLinks n))) (buildGraph ns)

makeUndirected:: Graph -> Graph
-- a key part of obsidian is graphs are undirected, so we address that here
makeUndirected g = Map.foldlWithKey' (\acc key value ->
    let references = Set.toList value
    in foldl (\acc2 ref -> Map.insertWith Set.union ref (Set.singleton key) acc2) acc references
    ) g g
