module Main where

import Graphics.Image as I
import Graphics.Image.IO

import System.IO

import Check

------------------
-- Hauptmethode --
------------------

main :: IO()
main = do
    let manImage = makeImageR VS (maxHoehe, maxBreite) (\(j, i) -> PixelY (Check.pixelCheck i j))
   
    putStrLn "Started"
    
    writeImage "mandelbrot_set.png" (manImage::Image VS Y Double)     
    
    putStrLn "showing image"

    displayImageUsing fehViewer True manImage
    
    putStrLn "done"
