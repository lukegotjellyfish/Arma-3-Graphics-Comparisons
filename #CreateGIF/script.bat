@echo off

set "input_folder=C:\Users\Lukeg\Desktop\Arma 3 Relevant PNGs\Arma-3-Graphics-Comparisons\[1] ###Quality###\[1] Sampling"
set "output_gif=C:\Users\Lukeg\Desktop\Arma 3 Relevant PNGs\Arma-3-Graphics-Comparisons\[1] ###Quality###\[1] Sampling\test.gif"


REM -resize 640x 
convert -delay 50 -loop 0 -layers OptimizePlus -quality 90 "%input_folder%/*.png" "%output_gif%"