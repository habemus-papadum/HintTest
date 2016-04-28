#!/bin/bash
SANDBOX="$(ls -d .cabal-sandbox/*.conf.d)"
ghc -package-db="$SANDBOX" -e 'import Main' -e "main \"$SANDBOX\""
