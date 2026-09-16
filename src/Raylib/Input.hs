module Raylib.Input (
    MouseButton (..),
    keyNull,
    keyApostrophe,
    keyComma,
    keyMinus,
    keyPeriod,
    keySlash,
    keyZero,
    keyOne,
    keyTwo,
    keyThree,
    keyFour,
    keyFive,
    keySix,
    keySeven,
    keyEight,
    keyNine,
    keySemicolon,
    keyEqual,
    keyA,
    keyB,
    keyC,
    keyD,
    keyE,
    keyF,
    keyG,
    keyH,
    keyI,
    keyJ,
    keyK,
    keyL,
    keyM,
    keyN,
    keyO,
    keyP,
    keyQ,
    keyR,
    keyS,
    keyT,
    keyU,
    keyV,
    keyW,
    keyX,
    keyY,
    keyZ,
    keyLeftBracket,
    keyBackslash,
    keyRightBracket,
    keyGrave,
    keySpace,
    keyEscape,
    keyEnter,
    keyTab,
    keyBackspace,
    keyInsert,
    keyDelete,
    keyRight,
    keyLeft,
    keyDown,
    keyUp,
    keyPageUp,
    keyPageDown,
    keyHome,
    keyEnd,
    keyCapsLock,
    keyScrollLock,
    keyNumLock,
    keyPrintScreen,
    keyPause,
    keyF1,
    keyF2,
    keyF3,
    keyF4,
    keyF5,
    keyF6,
    keyF7,
    keyF8,
    keyF9,
    keyF10,
    keyF11,
    keyF12,
    keyLeftShift,
    keyLeftControl,
    keyLeftAlt,
    keyLeftSuper,
    keyRightShift,
    keyRightControl,
    keyRightAlt,
    keyRightSuper,
    keyKbMenu,
    keyKp0,
    keyKp1,
    keyKp2,
    keyKp3,
    keyKp4,
    keyKp5,
    keyKp6,
    keyKp7,
    keyKp8,
    keyKp9,
    keyKpDecimal,
    keyKpDivide,
    keyKpMultiply,
    keyKpSubtract,
    keyKpAdd,
    keyKpEnter,
    keyKpEqual,
    keyBack,
    keyMenu,
    keyVolumeUp,
    keyVolumeDown,
    isKeyDown,
    isKeyPressed,
    isKeyPressedRepeat,
    isMouseButtonPressed,
    getMousePosition,
) where

import Foreign.Marshal.Alloc (alloca)
import Foreign.Storable (peek)
import Raylib.Internal.Foreign.Input (
    cGetMousePosition,
    cIsKeyDown,
    cIsKeyPressed,
    cIsKeyPressedRepeat,
    cIsMouseButtonPressed,
 )
import Raylib.Types (Vector2)

data MouseButton
    = MouseLeft
    | MouseRight
    | MouseMiddle
    deriving (Eq, Show, Enum)

keyNull, keyApostrophe, keyComma, keyMinus, keyPeriod, keySlash :: Int
keyZero, keyOne, keyTwo, keyThree, keyFour, keyFive, keySix, keySeven :: Int
keyEight, keyNine, keySemicolon, keyEqual, keyA, keyB, keyC, keyD, keyE :: Int
keyF, keyG, keyH, keyI, keyJ, keyK, keyL, keyM, keyN, keyO, keyP, keyQ :: Int
keyR, keyS, keyT, keyU, keyV, keyW, keyX, keyY, keyZ, keyLeftBracket :: Int
keyBackslash, keyRightBracket, keyGrave, keySpace, keyEscape, keyEnter :: Int
keyTab, keyBackspace, keyInsert, keyDelete, keyRight, keyLeft, keyDown :: Int
keyUp, keyPageUp, keyPageDown, keyHome, keyEnd, keyCapsLock, keyScrollLock :: Int
keyNumLock, keyPrintScreen, keyPause, keyF1, keyF2, keyF3, keyF4, keyF5 :: Int
keyF6, keyF7, keyF8, keyF9, keyF10, keyF11, keyF12, keyLeftShift :: Int
keyLeftControl, keyLeftAlt, keyLeftSuper, keyRightShift, keyRightControl :: Int
keyRightAlt, keyRightSuper, keyKbMenu, keyKp0, keyKp1, keyKp2, keyKp3 :: Int
keyKp4, keyKp5, keyKp6, keyKp7, keyKp8, keyKp9, keyKpDecimal, keyKpDivide :: Int
keyKpMultiply, keyKpSubtract, keyKpAdd, keyKpEnter, keyKpEqual, keyBack :: Int
keyMenu, keyVolumeUp, keyVolumeDown :: Int
keyNull = 0
keyApostrophe = 39
keyComma = 44
keyMinus = 45
keyPeriod = 46
keySlash = 47
keyZero = 48
keyOne = 49
keyTwo = 50
keyThree = 51
keyFour = 52
keyFive = 53
keySix = 54
keySeven = 55
keyEight = 56
keyNine = 57
keySemicolon = 59
keyEqual = 61
keyA = 65
keyB = 66
keyC = 67
keyD = 68
keyE = 69
keyF = 70
keyG = 71
keyH = 72
keyI = 73
keyJ = 74
keyK = 75
keyL = 76
keyM = 77
keyN = 78
keyO = 79
keyP = 80
keyQ = 81
keyR = 82
keyS = 83
keyT = 84
keyU = 85
keyV = 86
keyW = 87
keyX = 88
keyY = 89
keyZ = 90
keyLeftBracket = 91
keyBackslash = 92
keyRightBracket = 93
keyGrave = 96
keySpace = 32
keyEscape = 256
keyEnter = 257
keyTab = 258
keyBackspace = 259
keyInsert = 260
keyDelete = 261
keyRight = 262
keyLeft = 263
keyDown = 264
keyUp = 265
keyPageUp = 266
keyPageDown = 267
keyHome = 268
keyEnd = 269
keyCapsLock = 280
keyScrollLock = 281
keyNumLock = 282
keyPrintScreen = 283
keyPause = 284
keyF1 = 290
keyF2 = 291
keyF3 = 292
keyF4 = 293
keyF5 = 294
keyF6 = 295
keyF7 = 296
keyF8 = 297
keyF9 = 298
keyF10 = 299
keyF11 = 300
keyF12 = 301
keyLeftShift = 340
keyLeftControl = 341
keyLeftAlt = 342
keyLeftSuper = 343
keyRightShift = 344
keyRightControl = 345
keyRightAlt = 346
keyRightSuper = 347
keyKbMenu = 348
keyKp0 = 320
keyKp1 = 321
keyKp2 = 322
keyKp3 = 323
keyKp4 = 324
keyKp5 = 325
keyKp6 = 326
keyKp7 = 327
keyKp8 = 328
keyKp9 = 329
keyKpDecimal = 330
keyKpDivide = 331
keyKpMultiply = 332
keyKpSubtract = 333
keyKpAdd = 334
keyKpEnter = 335
keyKpEqual = 336
keyBack = 4
keyMenu = 5
keyVolumeUp = 24
keyVolumeDown = 25

isKeyDown :: Int -> IO Bool
isKeyDown key = (/= 0) <$> cIsKeyDown (fromIntegral key)

isKeyPressed :: Int -> IO Bool
isKeyPressed key = (/= 0) <$> cIsKeyPressed (fromIntegral key)

isKeyPressedRepeat :: Int -> IO Bool
isKeyPressedRepeat key = (/= 0) <$> cIsKeyPressedRepeat (fromIntegral key)

isMouseButtonPressed :: MouseButton -> IO Bool
isMouseButtonPressed button =
    (/= 0) <$> cIsMouseButtonPressed (fromIntegral (fromEnum button))

getMousePosition :: IO Vector2
getMousePosition = alloca $ \position -> cGetMousePosition position >> peek position
