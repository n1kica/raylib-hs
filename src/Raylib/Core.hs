module Raylib.Core (
    ConfigFlag (..),
    initWindow,
    closeWindow,
    beginDrawing,
    endDrawing,
    windowShouldClose,
    unlessWindowShouldClose,
    clearBackground,
    getFrameTime,
    drawFPS,
    setTargetFPS,
    setConfigFlags,
    getScreenWidth,
    getScreenHeight,
    getRenderWidth,
    getRenderHeight,
)
where

import Control.Monad (unless)
import Data.Bits ((.|.))
import Foreign.C.String (withCString)
import Foreign.C.Types (CUInt)
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
    cSetConfigFlags,
    cSetTargetFPS,
    cGetScreenHeight,
    cGetRenderWidth,
    cGetRenderHeight,
 )
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color)

data ConfigFlag
    = FlagVsyncHint
    | FlagFullscreenMode
    | FlagWindowResizable
    | FlagWindowUndecorated
    | FlagWindowHidden
    | FlagWindowMinimized
    | FlagWindowMaximized
    | FlagWindowUnfocused
    | FlagWindowTopmost
    | FlagWindowAlwaysRun
    | FlagWindowTransparent
    | FlagWindowHighDpi
    | FlagWindowMousePassthrough
    | FlagBorderlessWindowedMode
    | FlagMsaa4xHint
    | FlagInterlacedHint
    deriving (Eq, Show)

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

setTargetFPS :: Int -> IO ()
setTargetFPS fps = cSetTargetFPS (fromIntegral fps)

configFlagBit :: ConfigFlag -> CUInt
configFlagBit = \case
    FlagVsyncHint -> 0x40
    FlagFullscreenMode -> 0x2
    FlagWindowResizable -> 0x4
    FlagWindowUndecorated -> 0x8
    FlagWindowHidden -> 0x80
    FlagWindowMinimized -> 0x200
    FlagWindowMaximized -> 0x400
    FlagWindowUnfocused -> 0x800
    FlagWindowTopmost -> 0x1000
    FlagWindowAlwaysRun -> 0x100
    FlagWindowTransparent -> 0x10
    FlagWindowHighDpi -> 0x2000
    FlagWindowMousePassthrough -> 0x4000
    FlagBorderlessWindowedMode -> 0x8000
    FlagMsaa4xHint -> 0x20
    FlagInterlacedHint -> 0x10000

setConfigFlags :: [ConfigFlag] -> IO ()
setConfigFlags flags = cSetConfigFlags (foldr ((.|.) . configFlagBit) 0 flags)
