module Raylib.Internal.Foreign.Shapes (
    cDrawRectangle,
    cDrawRectangleRec,
) where

import Data.Word (Word32)
import Foreign.C.Types (CInt (..))
import Foreign.Ptr (Ptr)
import Raylib.Types (Rectangle)

foreign import ccall "HSDrawRectangle"
    cDrawRectangle :: CInt -> CInt -> CInt -> CInt -> Word32 -> IO ()

foreign import ccall "HSDrawRectangleRec"
    cDrawRectangleRec :: Ptr Rectangle -> Word32 -> IO ()
