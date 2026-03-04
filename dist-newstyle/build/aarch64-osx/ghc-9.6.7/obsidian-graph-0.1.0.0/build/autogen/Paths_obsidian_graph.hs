{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_obsidian_graph (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/benjaminheim/.cabal/bin"
libdir     = "/Users/benjaminheim/.cabal/lib/aarch64-osx-ghc-9.6.7/obsidian-graph-0.1.0.0-inplace"
dynlibdir  = "/Users/benjaminheim/.cabal/lib/aarch64-osx-ghc-9.6.7"
datadir    = "/Users/benjaminheim/.cabal/share/aarch64-osx-ghc-9.6.7/obsidian-graph-0.1.0.0"
libexecdir = "/Users/benjaminheim/.cabal/libexec/aarch64-osx-ghc-9.6.7/obsidian-graph-0.1.0.0"
sysconfdir = "/Users/benjaminheim/.cabal/etc"

getBinDir     = catchIO (getEnv "obsidian_graph_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "obsidian_graph_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "obsidian_graph_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "obsidian_graph_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "obsidian_graph_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "obsidian_graph_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
