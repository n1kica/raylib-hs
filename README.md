# raylib-hs

Haskell bindings for [raylib](https://www.raylib.com/).

## Basic window

This example creates an 800 × 450 window and draws `"Congrats! You created your first window!"` in the middle of the screen. 

```haskell
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
```

## Run the example

```sh
cabal run example
```
