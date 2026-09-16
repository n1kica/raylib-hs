module Raylib.Internal.Foreign.Text (
    c_drawText,
    cGetFontDefault,
    cMeasureTextEx,
    cDrawTextEx,
) where

import Data.Word (Word32)
import Foreign.C.String (CString)
import Foreign.C.Types (CFloat (..), CInt (..))
import Foreign.Ptr (Ptr)
import Raylib.Types (Vector2)

foreign import ccall "HSDrawText"
    c_drawText :: CString -> CInt -> CInt -> CInt -> Word32 -> IO ()

foreign import ccall "HSGetFontDefault"
    cGetFontDefault :: Ptr () -> IO ()

foreign import ccall "HSMeasureTextEx"
    cMeasureTextEx :: Ptr () -> CString -> CFloat -> CFloat -> Ptr Vector2 -> IO ()

foreign import ccall "HSDrawTextEx"
    cDrawTextEx :: Ptr () -> CString -> Ptr Vector2 -> CFloat -> CFloat -> Word32 -> IO ()
