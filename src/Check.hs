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

----------------------------
-- new New implementation --
----------------------------

-- checks if the recursion exit condition is met
checker :: Complex Double -> Bool
checker comp = (C.realPart comp) * (C.realPart comp) + (C.imagPart comp) * (C.imagPart comp) > 42

-- well, function that returns Gradient - number from [0,1] based of where it was on a scale from 1 to 255
manGradient n = (nD/255)
    where
        nD= fromIntegral n

-- just setting n to 0 xD
compNumbGradient = compNumbGradientSub 0 

-- recursibve function that returns the iteraation when it exits
compNumbGradientSub :: Int -> Complex Double -> Complex Double -> Int -> Double
compNumbGradientSub n x c haltN
  | n == haltN = manGradient n
  | checker x = manGradient n
  | otherwise = compNumbGradientSub (n+1) (manFn x c) c haltN

-- "adapter" function that adapts input of the pixelCheck complexPointCheck
complexPointCheck :: Double -> Double -> Double
complexPointCheck a b = compNumbGradient (0:+0) z 255 
    where
        z=a:+b

---------
-- gui --
---------

-- Point of Interest
pointX = 0
pointY = 0

-- Image resolution
breite :: Int
breite = 19200

hoehe :: Int
hoehe = 12800

-- Offset, so the Point Of Interest would be in the Center of the screen
xoffset = fromIntegral breite/2 + fromIntegral breite*pointX/multiplier
yoffset = fromIntegral hoehe/2 + fromIntegral hoehe*pointY/multiplier

-- Zoooooo~~~~~~oom
multiplier = 2

-- Achsen Massstab
xmultiplier=multiplier*1.5 
ymultplier=multiplier

-- Convert from Pixel koordinate to point on Complex plane
-- X-Achse
xToRe :: Int -> Double
xToRe x = (xF-xoffset)*xmultiplier/breiteF
     where
         xF = fromIntegral x :: Double
         breiteF = fromIntegral breite :: Double

-- Y-Achse
yToIm :: Int -> Double
yToIm y = (yF-yoffset)*ymultplier/hoeheF
    where
        yF = fromIntegral y :: Double
        hoeheF = fromIntegral hoehe :: Double

-- Checks, if the pixel with coords x y is in the Set (0,0 is display center)
pixelCheck :: Int -> Int -> Double
pixelCheck x y = complexPointCheck (xToRe x) (yToIm y)
