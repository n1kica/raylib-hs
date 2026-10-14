module Raylib.Internal.Foreign.Shapes (
    cDrawRectangle,
    cDrawRectangleRec,
    cDrawRectangleV,
    cDrawRectanglePro,
) where

import Data.Word (Word32)
import Foreign.C.Types (CFloat (..), CInt (..))
import Foreign.Ptr (Ptr)
import Raylib.Types (Rectangle, Vector2)

foreign import ccall "HSDrawRectangle"
    cDrawRectangle :: CInt -> CInt -> CInt -> CInt -> Word32 -> IO ()

foreign import ccall "HSDrawRectangleRec"
    cDrawRectangleRec :: Ptr Rectangle -> Word32 -> IO ()

foreign import ccall "HSDrawRectangleV"
    cDrawRectangleV :: Ptr Vector2 -> Ptr Vector2 -> Word32 -> IO ()

foreign import ccall "HSDrawRectanglePro"
    cDrawRectanglePro :: Ptr Rectangle -> Ptr Vector2 -> CFloat -> Word32 -> IO ()
