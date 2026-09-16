module Raylib.Text (
    Font,
    getFontDefault,
    drawText,
    drawTextEx,
    measureTextEx,
    textSubtext,
) where

import Foreign.C.String (withCString)
import Foreign.C.Types (CInt (..))
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Utils (with)
import Foreign.Ptr (Ptr, castPtr)
import Foreign.Storable (Storable (..), peekByteOff, pokeByteOff)
import Raylib.Internal.Foreign.Text (
    c_drawText,
    cDrawTextEx,
    cGetFontDefault,
    cMeasureTextEx,
 )
import Raylib.Internal.Utils (colorToWord32)
import Raylib.Types (Color, Rectangle, Texture, Vector2)

data Font = Font
    { baseSize :: Int
    , glyphCount :: Int
    , glyphPadding :: Int
    , texture :: Texture
    , recs :: Ptr Rectangle
    , glyphs :: Ptr ()
    }
    deriving (Eq, Show)

instance Storable Font where
    sizeOf _ = 32 + 2 * sizeOf (undefined :: Ptr ())
    alignment _ = alignment (undefined :: Ptr ())

    peek ptr =
        Font
            <$> (fromIntegral @CInt <$> peekByteOff ptr 0)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 4)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 8)
            <*> peekByteOff ptr 12
            <*> peekByteOff ptr 32
            <*> peekByteOff ptr (32 + sizeOf (undefined :: Ptr ()))

    poke ptr Font{baseSize, glyphCount, glyphPadding, texture, recs, glyphs} = do
        pokeByteOff ptr 0 (fromIntegral baseSize :: CInt)
        pokeByteOff ptr 4 (fromIntegral glyphCount :: CInt)
        pokeByteOff ptr 8 (fromIntegral glyphPadding :: CInt)
        pokeByteOff ptr 12 texture
        pokeByteOff ptr 32 recs
        pokeByteOff ptr (32 + sizeOf (undefined :: Ptr ())) glyphs

getFontDefault :: IO Font
getFontDefault = alloca $ \font -> cGetFontDefault (castPtr font) >> peek font

drawText :: String -> Int -> Int -> Int -> Color -> IO ()
drawText text x y fontSize color =
    withCString text $ \cText ->
        c_drawText cText (fromIntegral x) (fromIntegral y) (fromIntegral fontSize) (colorToWord32 color)

drawTextEx :: Font -> String -> Vector2 -> Float -> Float -> Color -> IO ()
drawTextEx font text position fontSize spacing tint =
    with font $ \fontPtr ->
        withCString text $ \cText ->
            with position $ \positionPtr ->
                cDrawTextEx
                    (castPtr fontPtr)
                    cText
                    positionPtr
                    (realToFrac fontSize)
                    (realToFrac spacing)
                    (colorToWord32 tint)

measureTextEx :: Font -> String -> Float -> Float -> IO Vector2
measureTextEx font text fontSize spacing =
    with font $ \fontPtr ->
        withCString text $ \cText ->
            alloca $ \result -> do
                cMeasureTextEx (castPtr fontPtr) cText (realToFrac fontSize) (realToFrac spacing) result
                peek result

textSubtext :: String -> Int -> Int -> String
textSubtext text position length = take length (drop position text)
