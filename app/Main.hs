module Main where

-- more imports!! YAY!!
import Graphics.Image as I
import Graphics.Image.IO

import System.IO

-- not forget to import our friend, module Check from Project /src/
import Check

------------------
-- Hauptmethode --
------------------

main :: IO()
main = do
    -- Image generation through pixelCheck from module Check by checking each pixel of the given matrix (hoehe and breite are set in Check)
    let manImage = makeImageR VS (hoehe, breite) (\(j, i) -> PixelY (Check.pixelCheck i j))
    
    -- debug Information
    putStrLn "Started"
    
    -- write generated Image to file to Project /
    writeImage "mandelbrot_set.png" (manImage::Image VS Y Double)     
    
    -- more Debugging information. everyone loves debugging information
    putStrLn "showing image"

    -- display the image via feh Image viewer - idk why there is a bool. check docks on Graphics.Image.IO
    displayImageUsing fehViewer True manImage
    
    -- thats just dumb at this point
    putStrLn "done"
