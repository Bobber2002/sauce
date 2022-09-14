@echo off
setlocal EnableDelayedExpansion
color

cls

rem Variables
rem -------------
    set COMMAND_PROMPT=cmd : 
    set "num=-1"
    set CURR_THEME=default
rem -------------

rem Calls
rem -------------
    CALL:SETUSER
rem -------------

rem Functions
rem -------------
    :SETUSER
       cls
       set /p USER="Username: "
       cls
       goto start

    :yesorno
       for /l %%i in (0 1 11) do echo.
       set /p YNO=%COMMAND_PROMPT%
       goto :eof
rem -------------

rem Main
rem -------------
    :start
       cls
       goto user

    :user
       cls
       for %%i in (h e l l "o " %USER%) do (
          <nul set /p = %%i
          powershell -nop -c "& {sleep -m 10}"
       )
       for /l %%i in (0 1 11) do echo.
       
       for %%i in (c m "d " ": ") do (
          <nul set /p = %%i
          powershell -nop -c "& {sleep -m 10}"
       )

       goto command_prompt

       EXIT

    :command_prompt
       set /p COMMAND=

       cls
       

       :check_command

          for %%i in ("help" "logout" "g/" "theme" "story" "idler") do (
             if "%COMMAND%"==%%i (
                goto break
             ) 
          )

          goto bad_command

       EXIT

       :cp_echo
          
          for /l %%i in (0 1 4) do echo.

          set /p COMMAND=%COMMAND_PROMPT%

          goto :check_command

          EXIT

    EXIT
rem -------------

rem Commands
rem -------------
       :Help
          echo help    ---^>   Displays this list
          echo logout  ---^>   Logs you out of the system
          echo g/      ---^>   Lets you run a command on the parent system
          echo idler   ---^>   Opens the idler game
          echo theme   ---^>   Display a list of aviable themes, and lets you change to a theme of choice
          goto new_command

       :logout
          echo Are you sure you want to log out? ^(y/n^)
          call:yesorno
          if "%YNO%"=="y" (
             call:SETUSER
          ) else (
             goto new_command
          )

       :g/
          echo Specify which command to run
          for /l %%i in (0 1 9) do echo.
          set /p G/_COMMAND=%COMMAND_PROMPT%g/
          cls
          echo g/ ^> %G/_COMMAND%
          echo.
          %G/_COMMAND%
          goto new_command

       :theme
          for %%i in (default dark batman ironman superman) do (
             if %CURR_THEME%==%%i (
                echo --current theme--^> %%i 
             ) else (
                echo ------------------ %%i
             )
          )
          echo.
          echo Which theme do you wish to change to? If you want the theme to stay the same, write the current themes name.
          for /l %%i in (0 1 11) do echo.
          set /p SET_THEME=%COMMAND_PROMPT%
          if %SET_THEME%==dark (
             color 08
          ) else if %SET_THEME%==batman (
             color 0e
          )else if %SET_THEME%==superman (
             color 14
          )else if %SET_THEME%==ironman (
             color 46
          )else if %SET_THEME%==default (
             color
          )else (
             cls
             echo ^>theme %SET_THEME%
             echo.
             echo %SET_THEME% is not a valid theme.
             goto new_command
          )
          set CURR_THEME=%SET_THEME%
          cls
          echo ^>theme %CURR_THEME%
          goto new_command

       :story
          for %%a in ("stories\*") do echo ---------- %%~na
          echo.
          echo Please write the name of the story you want to start.
          for /l %%i in (0 1 9) do echo.
          set /p CHOOSE_STORY=%COMMAND_PROMPT%
          cls
          for %%a in ("stories\*") do (
             if %CHOOSE_STORY%==%%~na (
                call stories/%CHOOSE_STORY%.bat
                cls
                goto start
             ) else (
                
          echo ^>%COMMAND%
          echo.
          echo %CHOOSE_STORY% is not a valid story.
          goto new_command
             )
          )
          echo ^>%COMMAND%
          echo.
          echo.
          goto new_command

       :idler
          
          echo Idler is a idle incremention game
          echo To gain points simply press enter constantly
          echo To exit the game write "shutdown"
          echo Tor more help write "help"
          echo.
          echo Do you wish to continue your last session?(y/n)

          call:yesorno
          
          if "%YNO%"=="y" (
             goto idler_continue   
          ) else (
             goto idler_newgame
          )

          :idler_newgame
             set /a INCREMENTER_AMOUNT=1
             set /a IDLER_POINTS=0           
             set /a INCREMENTER_PRICE=10
             goto idler_game

          :idler_continue
             set /a IDLER_POINTS=%IDLER_SAVEDPOINTS%
             set /a INCREMENTER_AMOUNT=%IDLER_SAVEDINCREMENTERS%     
             set /a INCREMENTER_PRICE=%IDLER_SAVEDINCREMENTERPRICE%
             goto idler_game

          :idler_game
             :idler_ticker
                cls
                set IDLER_DISPLAY=%IDLER_POINTS%
                echo %IDLER_DISPLAY%
                for /l %%i in (0 1 10) do echo.
                :add
                set add=0
                set /p add=">"
                if "%add%"=="shutdown" (
                   goto start                   
                ) else if "%add%" == "upgrades" (
                   set /a IDLER_POINTS-=%INCREMENTER_AMOUNT%
                   cls
                   echo incrementer     --- price: %INCREMENTER_PRICE%
                   echo                 --- will increase the amount of points per increment 
                   echo.
                   for /l %%i in (0 1 5) do echo.
                   goto :add
                ) else if "%add%" == "buy incrementer" (
                   set /a IDLER_POINTS-=%INCREMENTER_AMOUNT%
                   cls
                   if %IDLER_POINTS% geq %INCREMENTER_PRICE% (
                   set /a INCREMENTER_AMOUNT+=1
                   set /a INCREMENTER_PRICE+=5
                   set /a IDLER_POINTS-=%INCREMENTER_PRICE%
                   echo Bought incrementer!
                   ) else (
                      echo Insufficient amount of points
                   )
                   goto :add
                ) else (
                set /a IDLER_POINTS+=%INCREMENTER_AMOUNT%
                )
                set /a IDLER_SAVEDPOINTS=%IDLER_POINTS%
                set /a IDLER_SAVEDINCREMENTERS=%INCREMENTER_AMOUNT%
                set /a IDLER_SAVEDPINCREMENTERRICE=%INCREMENTER_PRICE%
                goto idler_ticker

           goto new_command

       :new_command
          for /l %%i in (0 1 3) do echo.
          goto cp_echo

       

    rem Bad command
    rem -------------
       :bad_command
          cls
          echo ^> %COMMAND%
          echo.
          echo %COMMAND% is not a valid command, try "help".
          goto new_command
    rem -------------

    rem New line
    rem -------------
       :break
          cls
          echo ^> %COMMAND%
          echo.
          goto %COMMAND%
    rem -------------
rem -------------



