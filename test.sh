#!/bin/bash
set -e

cabal sandbox init
cabal install
SANDBOX="$(ls -d .cabal-sandbox/*.conf.d)"
ghc -package-db="$SANDBOX" -e 'import Main' -e "main \"$SANDBOX\""
