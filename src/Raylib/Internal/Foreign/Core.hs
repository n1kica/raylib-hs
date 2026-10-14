module Raylib.Internal.Foreign.Core (
    cInitWindow,
    cBeginDrawing,
    cEndDrawing,
    cWindowShouldClose,
    cCloseWindow,
    cGetFrameTime,
    cDrawFPS,
    cClearBackground,
    cSetTargetFPS,
    cGetScreenWidth,
    cGetScreenHeight,
    cGetRenderWidth,
    cGetRenderHeight,
)
where

import Data.Word (Word32)
import Foreign.C.String (CString)
import Foreign.C.Types (CBool (..), CFloat (..), CInt (..))

foreign import capi "raylib.h InitWindow"
    cInitWindow :: CInt -> CInt -> CString -> IO ()

foreign import capi "raylib.h BeginDrawing"
    cBeginDrawing :: IO ()

foreign import capi "raylib.h EndDrawing"
    cEndDrawing :: IO ()

foreign import capi "raylib.h WindowShouldClose"
    cWindowShouldClose :: IO CBool

foreign import capi "raylib.h CloseWindow"
    cCloseWindow :: IO ()

foreign import capi "raylib.h GetFrameTime"
    cGetFrameTime :: IO CFloat

foreign import capi "raylib.h DrawFPS"
    cDrawFPS :: CInt -> CInt -> IO ()

foreign import ccall "HSClearBackground"
    cClearBackground :: Word32 -> IO ()

foreign import capi "raylib.h GetScreenWidth"
    cGetScreenWidth :: IO CInt

foreign import capi "raylib.h GetScreenHeight"
    cGetScreenHeight :: IO CInt

foreign import capi "raylib.h GetRenderWidth"
    cGetRenderWidth :: IO CInt

foreign import capi "raylib.h GetRenderHeight"
    cGetRenderHeight :: IO CInt

foreign import capi "raylib.h SetTargetFPS"
    cSetTargetFPS :: CInt -> IO ()
