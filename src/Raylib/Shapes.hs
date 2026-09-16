module Raylib.Shapes (
    drawRectangle,
    drawRectangleRec,
) where

import Foreign.Marshal.Alloc (alloca)
import Foreign.Storable (poke)
import Raylib.Internal.Foreign.Shapes (cDrawRectangle, cDrawRectangleRec)
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color, Rectangle)

drawRectangle :: Int -> Int -> Int -> Int -> Color -> IO ()
drawRectangle posX posY width height color =
    cDrawRectangle
        (fromIntegral posX)
        (fromIntegral posY)
        (fromIntegral width)
        (fromIntegral height)
        (colorToWord32 color)

drawRectangleRec :: Rectangle -> Color -> IO ()
drawRectangleRec rect color =
    alloca $ \rectPtr -> do
        poke rectPtr rect
        cDrawRectangleRec rectPtr (colorToWord32 color)
