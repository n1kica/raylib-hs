module Raylib.Internal.Utils (colorToWord32) where

import Data.Bits (shiftL, (.|.))
import Data.Word (Word32)
import Raylib.Types (Color (Color))

colorToWord32 :: Color -> Word32
colorToWord32 (Color red green blue alpha) =
    shiftL (fromIntegral red) 24
        .|. shiftL (fromIntegral green) 16
        .|. shiftL (fromIntegral blue) 8
        .|. fromIntegral alpha
