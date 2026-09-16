module Raylib.Audio (
    AudioStream (..),
    initAudioDevice,
    setAudioStreamBufferSizeDefault,
    loadAudioStream,
    playAudioStream,
    isAudioStreamProcessed,
    updateAudioStream,
) where

import Foreign.C.Types (CUInt (..))
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Utils (with)
import Foreign.Ptr (Ptr, castPtr)
import Foreign.Storable (Storable (..), peekByteOff, pokeByteOff)
import Raylib.Internal.Foreign.Audio (
    cInitAudioDevice,
    cIsAudioStreamProcessed,
    cLoadAudioStream,
    cPlayAudioStream,
    cSetAudioStreamBufferSizeDefault,
    cUpdateAudioStream,
 )
data AudioStream = AudioStream
    { audioBuffer :: Ptr ()
    , audioProcessor :: Ptr ()
    , audioSampleRate :: Word
    , audioSampleSize :: Word
    , audioChannels :: Word
    }
    deriving (Eq, Show)

instance Storable AudioStream where
    sizeOf _ = 32
    alignment _ = 8

    peek ptr =
        AudioStream
            <$> peekByteOff ptr 0
            <*> peekByteOff ptr 8
            <*> (fromIntegral @CUInt <$> peekByteOff ptr 16)
            <*> (fromIntegral @CUInt <$> peekByteOff ptr 20)
            <*> (fromIntegral @CUInt <$> peekByteOff ptr 24)

    poke ptr AudioStream{audioBuffer, audioProcessor, audioSampleRate, audioSampleSize, audioChannels} = do
        pokeByteOff ptr 0 audioBuffer
        pokeByteOff ptr 8 audioProcessor
        pokeByteOff ptr 16 (fromIntegral audioSampleRate :: CUInt)
        pokeByteOff ptr 20 (fromIntegral audioSampleSize :: CUInt)
        pokeByteOff ptr 24 (fromIntegral audioChannels :: CUInt)

initAudioDevice :: IO ()
initAudioDevice = cInitAudioDevice

setAudioStreamBufferSizeDefault :: Int -> IO ()
setAudioStreamBufferSizeDefault = cSetAudioStreamBufferSizeDefault . fromIntegral

loadAudioStream :: Int -> Int -> Int -> IO AudioStream
loadAudioStream sampleRate sampleSize channels =
    alloca $ \streamPtr -> do
        cLoadAudioStream
            (fromIntegral sampleRate)
            (fromIntegral sampleSize)
            (fromIntegral channels)
            (castPtr streamPtr)
        peek streamPtr

playAudioStream :: AudioStream -> IO ()
playAudioStream stream = with stream $ cPlayAudioStream . castPtr

isAudioStreamProcessed :: AudioStream -> IO Bool
isAudioStreamProcessed stream =
    with stream $ \ptr -> (/= 0) <$> cIsAudioStreamProcessed (castPtr ptr)

updateAudioStream :: AudioStream -> Ptr a -> Int -> IO ()
updateAudioStream stream buffer frameCount =
    with stream $ \streamPtr ->
        cUpdateAudioStream (castPtr streamPtr) (castPtr buffer) (fromIntegral frameCount)
