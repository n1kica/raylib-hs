module Raylib.Core (
    initWindow,
    closeWindow,
    beginDrawing,
    endDrawing,
    windowShouldClose,
    unlessWindowShouldClose,
    clearBackground,
    getFrameTime,
    drawFPS,
)
where

import Control.Monad (unless)
import Foreign.C.String (withCString)
import Raylib.Internal.Foreign.Core (
    c_beginDrawing,
    c_clearBackground,
    c_closeWindow,
    c_drawFPS,
    c_endDrawing,
    c_getFrameTime,
    c_initWindow,
    c_windowShouldClose,
 )
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color)

initWindow :: Int -> Int -> String -> IO ()
initWindow width height title =
    withCString title $
        c_initWindow (fromIntegral width) (fromIntegral height)

closeWindow :: IO ()
closeWindow = c_closeWindow

beginDrawing :: IO ()
beginDrawing = c_beginDrawing

endDrawing :: IO ()
endDrawing = c_endDrawing

windowShouldClose :: IO Bool
windowShouldClose = (/= 0) <$> c_windowShouldClose

unlessWindowShouldClose :: IO () -> IO ()
unlessWindowShouldClose action = windowShouldClose >>= \shouldClose -> unless shouldClose action

clearBackground :: Color -> IO ()
clearBackground color = c_clearBackground (colorToWord32 color)

getFrameTime :: IO Float
getFrameTime = realToFrac <$> c_getFrameTime

drawFPS :: Int -> Int -> IO ()
drawFPS x y = c_drawFPS (fromIntegral x) (fromIntegral y)
