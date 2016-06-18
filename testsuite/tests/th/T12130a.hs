{-# LANGUAGE TemplateHaskell #-}

module T12130a where

import Language.Haskell.TH

data Block = Block
    { blockSelector :: ()
    }

block :: Q Exp
block =
    [| Block {
         -- Using record syntax is neccesary to trigger the bug.
         blockSelector = ()
       }
    |]
