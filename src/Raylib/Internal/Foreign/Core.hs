module Raylib.Internal.Foreign.Core (
    c_initWindow,
    c_beginDrawing,
    c_endDrawing,
    c_windowShouldClose,
    c_closeWindow,
    c_getFrameTime,
    c_drawFPS,
    c_clearBackground,
)
where

import Data.Word (Word32)
import Foreign.C.String (CString)
import Foreign.C.Types (CBool (..), CFloat (..), CInt (..))

foreign import capi "raylib.h InitWindow"
    c_initWindow :: CInt -> CInt -> CString -> IO ()

foreign import capi "raylib.h BeginDrawing"
    c_beginDrawing :: IO ()

foreign import capi "raylib.h EndDrawing"
    c_endDrawing :: IO ()

foreign import capi "raylib.h WindowShouldClose"
    c_windowShouldClose :: IO CBool

foreign import capi "raylib.h CloseWindow"
    c_closeWindow :: IO ()

foreign import capi "raylib.h GetFrameTime"
    c_getFrameTime :: IO CFloat

foreign import capi "raylib.h DrawFPS"
    c_drawFPS :: CInt -> CInt -> IO ()

foreign import ccall "HSClearBackground"
    c_clearBackground :: Word32 -> IO ()
