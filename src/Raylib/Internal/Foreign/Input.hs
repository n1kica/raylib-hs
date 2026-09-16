module Raylib.Internal.Foreign.Input (
    cIsKeyDown,
    cIsKeyPressed,
    cIsKeyPressedRepeat,
    cIsMouseButtonPressed,
    cGetMousePosition,
) where

import Foreign.C.Types (CBool (..), CInt (..))
import Foreign.Ptr (Ptr)
import Raylib.Types (Vector2)

foreign import capi "raylib.h IsKeyDown"
    cIsKeyDown :: CInt -> IO CBool

foreign import capi "raylib.h IsKeyPressed"
    cIsKeyPressed :: CInt -> IO CBool

foreign import capi "raylib.h IsKeyPressedRepeat"
    cIsKeyPressedRepeat :: CInt -> IO CBool

foreign import capi "raylib.h IsMouseButtonPressed"
    cIsMouseButtonPressed :: CInt -> IO CBool

foreign import ccall "HSGetMousePosition"
    cGetMousePosition :: Ptr Vector2 -> IO ()
