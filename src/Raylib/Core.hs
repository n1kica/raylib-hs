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
    getScreenWidth,
    getScreenHeight,
    getRenderWidth,
    getRenderHeight,
)
where

import Control.Monad (unless)
import Foreign.C.String (withCString)
import Raylib.Internal.Foreign.Core (
    cBeginDrawing,
    cClearBackground,
    cCloseWindow,
    cDrawFPS,
    cEndDrawing,
    cGetFrameTime,
    cInitWindow,
    cWindowShouldClose,
    cGetScreenWidth,
    cGetScreenHeight,
    cGetRenderWidth,
    cGetRenderHeight,
 )
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color)

initWindow :: Int -> Int -> String -> IO ()
initWindow width height title =
    withCString title $
        cInitWindow (fromIntegral width) (fromIntegral height)

closeWindow :: IO ()
closeWindow = cCloseWindow

beginDrawing :: IO ()
beginDrawing = cBeginDrawing

endDrawing :: IO ()
endDrawing = cEndDrawing

windowShouldClose :: IO Bool
windowShouldClose = (/= 0) <$> cWindowShouldClose

unlessWindowShouldClose :: IO () -> IO ()
unlessWindowShouldClose action = windowShouldClose >>= \shouldClose -> unless shouldClose action

clearBackground :: Color -> IO ()
clearBackground color = cClearBackground (colorToWord32 color)

getFrameTime :: IO Float
getFrameTime = realToFrac <$> cGetFrameTime

drawFPS :: Int -> Int -> IO ()
drawFPS x y = cDrawFPS (fromIntegral x) (fromIntegral y)

getScreenWidth :: IO Int
getScreenWidth = fromIntegral <$> cGetScreenWidth

getScreenHeight :: IO Int
getScreenHeight = fromIntegral <$> cGetScreenHeight

getRenderWidth :: IO Int
getRenderWidth = fromIntegral <$> cGetRenderWidth

getRenderHeight :: IO Int
getRenderHeight = fromIntegral <$> cGetRenderHeight
