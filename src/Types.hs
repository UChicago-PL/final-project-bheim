module Types where

import qualified Data.Map.Strict as Map
import qualified Data.Set as Set

data Note =  Note{
    name :: NoteName
    ,content :: NoteContent
    , noteLinks :: [NoteName]
} deriving (Show, Eq)

type NoteName = String

type NoteContent = String

type Graph = Map.Map NoteName (Set.Set NoteName)

type Cluster = Set.Set Note

data Triangle = Triangle{
 tNoteA :: NoteName
, tNoteB :: NoteName
, tCommon :: [NoteName]
} deriving (Show, Eq)