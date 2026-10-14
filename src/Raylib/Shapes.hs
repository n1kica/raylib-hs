module Raylib.Shapes (
    drawRectangle,
    drawRectangleRec,
    drawRectangleV,
    drawRectanglePro,
) where

import Foreign.Marshal.Utils (with)
import Raylib.Internal.Foreign.Shapes (
    cDrawRectangle,
    cDrawRectanglePro,
    cDrawRectangleRec,
    cDrawRectangleV,
    )
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color, Rectangle, Vector2)

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

drawRectangleV :: Vector2 -> Vector2 -> Color -> IO ()
drawRectangleV position size color =
    with position $ \positionPtr ->
        with size $ \sizePtr ->
            cDrawRectangleV positionPtr sizePtr (colorToWord32 color)

drawRectanglePro :: Rectangle -> Vector2 -> Float -> Color -> IO ()
drawRectanglePro rect origin rotation color =
    with rect $ \rectPtr ->
        with origin $ \originPtr ->
            cDrawRectanglePro
                rectPtr
                originPtr
                (realToFrac rotation)
                (colorToWord32 color)
