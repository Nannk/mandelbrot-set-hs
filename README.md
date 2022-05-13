# mandelbrot-set
use ghc-9.0.2 with stack to build the project:

`stack update` - updates dependencies

`stack build` - builds the project

`stack run` - builds (if not built) and starts the executable

i would recomment to use `stack clean` before `stack run`

 

WARNING!!!

The default resolution is set to 19200x12800 - it takes about 20 minutes to render the Image using i7-8750H 

If you want to test - i would recommend to lower the resolution to 1200x800 or even lower 
