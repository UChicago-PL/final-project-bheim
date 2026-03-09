module Clusters where
import Types
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Paths

connectedComponents:: Graph -> [Cluster]
connectedComponents g = go (Map.keysSet g)
    where
        go remaining =
            if Set.null remaining
                then []
            else
                let start = Set.findMin remaining
                    clust = bfs g start
                    remaining' = Set.difference remaining clust
                in clust : go remaining'