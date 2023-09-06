@echo off

for /r %%I in (*.png) do (
	optipng -o 1 -preserve "%%I"
)