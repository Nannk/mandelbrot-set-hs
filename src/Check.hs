module Check where
-- Ein Paar schöner Imports =)
import Data.List

-- Complexer Zahlen und Tuples
import Data.Complex as C

-- Graphische Lib, die GHCi von HLS nicht sehen will, auch wenn stack ghc die findet
import Graphics.Image as Gi
import Graphics.Image.IO as GiIO

-----------
-- Check --
-----------

-- Hauptfunktion: x_n = x_(n-1)² + c
manFn :: Complex Double -> Complex Double -> Complex Double
manFn x c = x*x + c

-------------------------
-- new imnplementation --
-------------------------
    {--
manList :: Int -> (Int,Complex Double) -> Complex Double ->  [(Int,Complex Double)]
manList n x c
  | n==0                                                                                                 = []
  | (C.realPart (snd x)) * (C.realPart (snd x)) + (C.imagPart (snd x)) * (C.imagPart (snd x)) > 42       = [] 
  | otherwise                                                                                            = x:(manList (n-1) (n-1,(manFn (snd x) c)) c)


manCheck :: [(Int, Complex Double)] -> Double
manCheck xs = 1-(xsF/255)
   where
        xsF = fromIntegral (fst (last xs)) :: Double


floatCheck :: Double -> Double -> Double
floatCheck a b = manCheck (manList 255 (255,0:+0) z )
    where
        z=a:+b
--}

----------------------------
-- new New implementation --
----------------------------

checker :: Complex Double -> Bool
checker comp = (C.realPart comp) * (C.realPart comp) + (C.imagPart comp) * (C.imagPart comp) > 42


manGradient n = 1-(nD/255)
    where
        nD= fromIntegral n

compNumbGradient = compNumbGradientSub 0 

compNumbGradientSub :: Int -> Complex Double -> Complex Double -> Int -> Double
compNumbGradientSub n x c haltN
  | n == haltN = manGradient n
  | checker x = manGradient n
  | otherwise = compNumbGradientSub (n+1) (manFn x c) c haltN

complexPointCheck :: Double -> Double -> Double
complexPointCheck a b = compNumbGradient (0:+0) z 255 
    where
        z=a:+b

---------
-- gui --
---------

-- ein paar nutzlicher konstanten

-- Image resolution
pointX = 0
pointY = 0

maxBreite :: Int
maxBreite = 1920

maxHoehe :: Int
maxHoehe = 1280

xoffset = fromIntegral maxBreite/2 + fromIntegral maxBreite*pointX/multiplier
yoffset = fromIntegral maxHoehe/2 + fromIntegral maxHoehe*pointY/multiplier

-- Zoooooo~~~~~~oom
multiplier = 2

xmultiplier=multiplier*1.5 --more like Achsen-Maßstab...
ymultplier=multiplier

-- convert point to offset
pointToOffsetX :: Int -> Double
pointToOffsetX x = xmultiplier*fromIntegral maxBreite/2

-- Convertation - funktionen
-- X-Achse
xToRe :: Int -> Double
xToRe x = (xF-xoffset)*xmultiplier/maxBreiteF
     where
         xF = fromIntegral x :: Double
         maxBreiteF = fromIntegral maxBreite :: Double

-- Y-Achse
yToIm :: Int -> Double
yToIm y = (yF-yoffset)*ymultplier/maxHoeheF
    where
        yF = fromIntegral y :: Double
        maxHoeheF = fromIntegral maxHoehe :: Double

-- Checks, if the pixel with coords x y is in the Set (0,0 is display center)
pixelCheck :: Int -> Int -> Double
pixelCheck x y = complexPointCheck (xToRe x) (yToIm y)
