module Raylib.Shapes (
    drawRectangle,
    drawRectangleRec,
) where

import Foreign.Marshal.Utils (with)
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
    with rect $ \rectPtr ->
        cDrawRectangleRec rectPtr (colorToWord32 color)
