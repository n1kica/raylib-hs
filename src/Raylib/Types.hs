module Raylib.Types (
    Color (..),
    Vector2 (..),
    Rectangle (..),
    Texture (..),
    lightGray,
    gray,
    darkGray,
    yellow,
    gold,
    orange,
    pink,
    red,
    maroon,
    green,
    lime,
    darkGreen,
    skyBlue,
    blue,
    darkBlue,
    purple,
    violet,
    darkPurple,
    beige,
    brown,
    darkBrown,
    white,
    black,
    blank,
    magenta,
    rayWhite,
) where

import Data.Word (Word8)
import Foreign.C.Types (CFloat (..), CInt (..), CUInt (..))
import Foreign.Storable (Storable (..), peekByteOff, pokeByteOff)

data Color = Color
    { r :: Word8
    , g :: Word8
    , b :: Word8
    , a :: Word8
    }
    deriving (Eq, Show)

data Vector2 = Vector2
    { x :: Float
    , y :: Float
    }
    deriving (Eq, Show)

instance Storable Vector2 where
    sizeOf _ = 2 * sizeOf (0 :: CFloat)
    alignment _ = alignment (0 :: CFloat)

    peek ptr =
        Vector2
            <$> (realToFrac @CFloat <$> peekByteOff ptr 0)
            <*> (realToFrac @CFloat <$> peekByteOff ptr (sizeOf (0 :: CFloat)))

    poke ptr Vector2{x, y} = do
        pokeByteOff ptr 0 (realToFrac x :: CFloat)
        pokeByteOff ptr (sizeOf (0 :: CFloat)) (realToFrac y :: CFloat)

data Rectangle = Rectangle
    { x :: Float
    , y :: Float
    , width :: Float
    , height :: Float
    }
    deriving (Eq, Show)

instance Storable Rectangle where
    sizeOf _ = 4 * sizeOf (0 :: CFloat)
    alignment _ = alignment (0 :: CFloat)

    peek ptr =
        Rectangle
            <$> (realToFrac @CFloat <$> peekByteOff ptr 0)
            <*> (realToFrac @CFloat <$> peekByteOff ptr (sizeOf (0 :: CFloat)))
            <*> (realToFrac @CFloat <$> peekByteOff ptr (2 * sizeOf (0 :: CFloat)))
            <*> (realToFrac @CFloat <$> peekByteOff ptr (3 * sizeOf (0 :: CFloat)))

    poke ptr Rectangle{x, y, width, height} = do
        pokeByteOff ptr 0 (realToFrac x :: CFloat)
        pokeByteOff ptr (sizeOf (0 :: CFloat)) (realToFrac y :: CFloat)
        pokeByteOff ptr (2 * sizeOf (0 :: CFloat)) (realToFrac width :: CFloat)
        pokeByteOff ptr (3 * sizeOf (0 :: CFloat)) (realToFrac height :: CFloat)

data Texture = Texture
    { id :: Int
    , width :: Int
    , height :: Int
    , mipmaps :: Int
    , format :: Int
    }
    deriving (Eq, Show)

instance Storable Texture where
    sizeOf _ = sizeOf (0 :: CUInt) + 4 * sizeOf (0 :: CInt)
    alignment _ = alignment (0 :: CUInt)

    peek ptr =
        Texture
            <$> (fromIntegral @CUInt <$> peekByteOff ptr 0)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 4)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 8)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 12)
            <*> (fromIntegral @CInt <$> peekByteOff ptr 16)

    poke ptr Texture{id, width, height, mipmaps, format} = do
        pokeByteOff ptr 0 (fromIntegral id :: CUInt)
        pokeByteOff ptr 4 (fromIntegral width :: CInt)
        pokeByteOff ptr 8 (fromIntegral height :: CInt)
        pokeByteOff ptr 12 (fromIntegral mipmaps :: CInt)
        pokeByteOff ptr 16 (fromIntegral format :: CInt)

lightGray :: Color
lightGray = Color 200 200 200 255

gray :: Color
gray = Color 130 130 130 255

darkGray :: Color
darkGray = Color 80 80 80 255

yellow :: Color
yellow = Color 253 249 0 255

gold :: Color
gold = Color 255 203 0 255

orange :: Color
orange = Color 255 161 0 255

pink :: Color
pink = Color 255 109 194 255

red :: Color
red = Color 230 41 55 255

maroon :: Color
maroon = Color 190 33 55 255

green :: Color
green = Color 0 228 48 255

lime :: Color
lime = Color 0 158 47 255

darkGreen :: Color
darkGreen = Color 0 117 44 255

skyBlue :: Color
skyBlue = Color 102 191 255 255

blue :: Color
blue = Color 0 121 241 255

darkBlue :: Color
darkBlue = Color 0 82 172 255

purple :: Color
purple = Color 200 122 255 255

violet :: Color
violet = Color 135 60 190 255

darkPurple :: Color
darkPurple = Color 112 31 126 255

beige :: Color
beige = Color 211 176 131 255

brown :: Color
brown = Color 127 106 79 255

darkBrown :: Color
darkBrown = Color 76 63 47 255

white :: Color
white = Color 255 255 255 255

black :: Color
black = Color 0 0 0 255

blank :: Color
blank = Color 0 0 0 0

magenta :: Color
magenta = Color 255 0 255 255

rayWhite :: Color
rayWhite = Color 245 245 245 255
