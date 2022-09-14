@echo off

echo       ###        ##    ##       #########         #########    #########     ###     
echo   ###########   ###    ###     ###    ###        ###    ###   ###    ### ########### 
echo      ########   ###    ###     ###    ##         ###    ###   ###    ###    ######## 
echo       ###   #  #############  #######           ###########   ###    ###     ###   # 
echo       ###     #############  ########          ##########   ############     ###     
echo       ###       ###    ###     ###    ##       ############   ###    ###     ###     
echo       ###       ###    ###     ###    ###        ###    ###   ###    ###     ###     
echo      ######     ###    ##      ##########        ###    ###   ###    ##     ######   
echo                                                  ###    ###                                                                                                         


    echo What is this rats name?
    timeout /t 1 /nobreak >nul
    echo.
    set /p name=">"
    echo.
    echo This is a story about the rat %name%
    timeout /t 1 /nobreak >nul
    echo.
    echo If %name%'s story is currently on going, please write last known chaptername:
    echo.
    set /p chapter=">"
    findstr /i /r /c:"^[ ]*:%chapter%\>" "%~f0" >nul 2>nul && goto %chapter%
    echo.
    echo %name% lived in a small village south-east of the south pole
    timeout /t 1 /nobreak >nul
    echo Alone in their house, %name% would often feel very lonely
    timeout /t 1 /nobreak >nul
       :stayorfind
    echo Will %name% stay in the house and be alone, or will it try and find companionship?
    timeout /t 1 /nobreak >nul
    echo.
    echo Choose now:("stay"/"find")
    echo.
    set /p choice=">"
    goto endstory
    echo.
    if "%choice%"=="stay" (
       echo %name% decided to stay home, alone.
       timeout /t 1 /nobreak >nul
       echo As time went passed slowly by, %name% fell asleep.
       timeout /t 1 /nobreak >nul
       echo %name% woke up feeling refreshed, and maybe not they'd try and find some companionship.
       goto stayorfind
    ) else if "%choice%"=="find" (
       break
    ) else (
       goto stayorfind
    )
       echo %name% left their house in a hurry!
       echo They felt hopeful that they'd find a true friend today.

        

    echo THE END.
    pause >nul
    goto :eof

:endstory
    if "%choice%"=="endstory" (
       exit /b
    ) else (
       goto :eof
    )
