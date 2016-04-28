module Main where

import SomeType

import Data.List
import Text.Printf
import Language.Haskell.Interpreter
import Language.Haskell.Interpreter.Unsafe

testHint :: Interpreter SomeType
testHint = do
  set [searchPath := ["plugin"]]
  loadModules ["TestHint"]
  getLoadedModules >>= liftIO . print
  setTopLevelModules ["TestHint"]
  setImports["Prelude", "SomeType"]
  getModuleExports "TestHint" >>= liftIO . print
  getModuleExports "SomeType" >>= liftIO . print
  interpret "test 5" (as :: SomeType)



errorString :: InterpreterError -> String
errorString (WontCompile es) = intercalate "\n" (header : map unbox es)
  where
    header = "ERROR: Won't compile:"
    unbox (GhcError e) = e
errorString e = show e

main :: IO ()
          -- change this path to your sandbox as appropriate, or remove entirely if you installed HintTest globally.
main = do r <- unsafeRunInterpreterWithArgs ["-package-db=.cabal-sandbox/x86_64-osx-ghc-7.10.2-packages.conf.d/"] testHint
          case r of
            Left err -> putStrLn $ errorString err
            Right fn -> do 
              putStrLn "got something"
              print fn
