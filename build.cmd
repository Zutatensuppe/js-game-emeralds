@echo off


echo;
echo;
echo ---------------------------------------
echo Minifying Js
echo ---------------------------------------
echo uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/lib/jsfxr.min.js -- src/lib/jsfxr.js
call uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/lib/jsfxr.min.js -- src/lib/jsfxr.js

echo uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/lib/seq.min.js -- src/lib/seq.js
call uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/lib/seq.min.js -- src/lib/seq.js

echo uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/game.min.js -- src/game.js
call uglifyjs --compress --mangle --mangle-props --mangle-regex="/^_/" --o src/game.min.js -- src/game.js



echo;
echo;
echo ---------------------------------------
echo Creating Zip
echo ---------------------------------------
echo rm dist/dist.zip
call rm dist/dist.zip
call cd src
::echo 7za a -mm=PPMd -mx9 ../dist/dist.zip game.min.js index.html sprites.png lib/jsfxr.min.js lib/seq.min.js
::call 7za a -mm=PPMd -mx9 ../dist/dist.zip game.min.js index.html sprites.png lib/jsfxr.min.js lib/seq.min.js
::echo 7za a -mx9 ../dist/dist.zip game.min.js index.html sprites.png lib/jsfxr.min.js lib/seq.min.js
::call 7za a -mx9 ../dist/dist.zip game.min.js index.html sprites.png lib/jsfxr.min.js lib/seq.min.js
call rm c.js
call type NUL > c.js
copy lib\jsfxr.min.js j.js
copy lib\seq.min.js s.js
copy game.min.js g.js
type j.js s.js g.js > c.js
call rm j.js
call rm s.js
call rm g.js
call 7za a -mx9 ../dist/dist.zip c.js index.html i.png
call cd ..



echo;
echo;
echo ---------------------------------------
echo Summary
echo ---------------------------------------
set size=0
set sizelimit=13312
call :filesize dist/dist.zip
if %size% LEQ %sizelimit% (
echo File Size: %size% ^<= %sizelimit% ^(Ok^!^)
) else (
echo File Size: %size% ^> %sizelimit% ^(Warning, limit exceeded^!^)
)
goto :eof


:filesize
  set size=%~z1
  exit /b 0