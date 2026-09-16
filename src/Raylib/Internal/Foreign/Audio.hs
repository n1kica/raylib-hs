module Raylib.Internal.Foreign.Audio (
    cInitAudioDevice,
    cSetAudioStreamBufferSizeDefault,
    cLoadAudioStream,
    cPlayAudioStream,
    cIsAudioStreamProcessed,
    cUpdateAudioStream,
) where

import Foreign.C.Types (CBool (..), CInt (..), CUInt (..))
import Foreign.Ptr (Ptr)

foreign import capi "raylib.h InitAudioDevice"
    cInitAudioDevice :: IO ()

foreign import capi "raylib.h SetAudioStreamBufferSizeDefault"
    cSetAudioStreamBufferSizeDefault :: CInt -> IO ()

foreign import ccall "HSLoadAudioStream"
    cLoadAudioStream :: CUInt -> CUInt -> CUInt -> Ptr () -> IO ()

foreign import ccall "HSPlayAudioStream"
    cPlayAudioStream :: Ptr () -> IO ()

foreign import ccall "HSIsAudioStreamProcessed"
    cIsAudioStreamProcessed :: Ptr () -> IO CBool

foreign import ccall "HSUpdateAudioStream"
    cUpdateAudioStream :: Ptr () -> Ptr () -> CInt -> IO ()
