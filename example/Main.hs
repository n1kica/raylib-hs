module Main (main) where

import Raylib

main :: IO ()
main = do
    initWindow 800 450 "raylib example - basic window"
    let loop =
            unlessWindowShouldClose $ do
                beginDrawing
                clearBackground rayWhite
                drawText "Congrats! You created your first window!" 190 200 20 lightGray
                endDrawing
                loop
    loop
    closeWindow
