module TestHint(test) where

import Prelude
import SomeType as ST

test :: Int -> SomeType 
test x = Ploop (x*x)
