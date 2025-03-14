@echo off
chcp 65001 >nul
title Windows C盘清理工具 v1.0
color 0A
setlocal enabledelayedexpansion

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo 需要管理员权限运行此脚本...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~0' -Verb RunAs"
    exit /b
)

:: 主菜单
:MainMenu
cls
echo ========================================
echo        Windows C盘清理工具 v1.0
echo ========================================
echo  [1] 系统临时文件清理
echo  [2] 浏览器缓存清理
echo  [3] 聊天软件缓存清理
echo  [4] 媒体软件缓存清理
echo  [5] 系统组件清理(需谨慎)
echo  [6] 全面清理(执行所有选项)
echo  [7] 退出
echo ========================================
echo 请选择操作(输入数字):
set /p choice=

if "%choice%"=="1" goto :SystemTemp
if "%choice%"=="2" goto :BrowserCache
if "%choice%"=="3" goto :ChatCache
if "%choice%"=="4" goto :MediaCache
if "%choice%"=="5" goto :SystemComp
if "%choice%"=="6" goto :FullClean
if "%choice%"=="7" exit
goto :MainMenu

:: 创建日志目录
:CreateLogDir
if not exist "%temp%\CleanTool" mkdir "%temp%\CleanTool"
set "LOGFILE=%temp%\CleanTool\clean_%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%%time:~6,2%.log"
echo Windows C盘清理工具日志 - %date% %time% > "%LOGFILE%"
exit /b

:: 记录日志
:LogMessage
echo %date% %time% - %~1 >> "%LOGFILE%"
exit /b

:: 系统临时文件清理
:SystemTemp
call :CreateLogDir
echo 正在清理系统临时文件...
call :LogMessage "开始清理系统临时文件"

:: Windows临时文件
set "USERPATH=%userprofile%\AppData\Local\Temp"
call :DeleteFolder
call :LogMessage "清理了 %userprofile%\AppData\Local\Temp"

:: Windows更新缓存
set "USERPATH=%windir%\SoftwareDistribution\download"
call :DeleteFolder
call :LogMessage "清理了 %windir%\SoftwareDistribution\download"

:: 预读取文件
set "USERPATH=%windir%\Prefetch"
call :DeleteFolder
call :LogMessage "清理了 %windir%\Prefetch"

:: 最近使用的文件
set "USERPATH=%appdata%\Microsoft\Windows\Recent"
call :DeleteFolder
call :LogMessage "清理了 %appdata%\Microsoft\Windows\Recent"

:: IE缓存
set "USERPATH=%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE"
call :DeleteFolder
call :LogMessage "清理了 IE缓存"

:: 离线网页
set "USERPATH=%windir%\Offline Web Pages"
call :DeleteFolder

:: 崩溃转储
set "USERPATH=%localappdata%\CrashDumps"
call :DeleteFolder
call :LogMessage "清理了崩溃转储文件"

echo 系统临时文件清理完成!
pause
goto :MainMenu

:: 浏览器缓存清理
:BrowserCache
call :CreateLogDir
echo 正在清理浏览器缓存...
call :LogMessage "开始清理浏览器缓存"

:: Chrome缓存
set "USERPATH=%localappdata%\Google\Chrome\User Data\Default\Cache\Cache_Data"
call :DeleteFolder
set "USERPATH=%localappdata%\Google\GoogleUpdater"
call :DeleteFolder
call :LogMessage "清理了Chrome缓存"

:: Edge缓存
set "Edge_PATH=%localappdata%\Microsoft\Edge\User Data"
set "USERPATH=%Edge_PATH%\Default\Service Worker\CacheStorage"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\Default\Cache"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\Default\Code Cache"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\Default\GPUCache"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\Default\DawnCache"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\Crashpad"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\GrShaderCache"
call :DeleteFolder
set "USERPATH=%Edge_PATH%\ShaderCache"
call :DeleteFolder
call :LogMessage "清理了Edge缓存"

:: 旧版Edge缓存
set "USERPATH=%localappdata%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\Temp"
call :DeleteFolder
set "USERPATH=%localappdata%\Packages\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\AC\INetCache"
call :DeleteFolder
call :LogMessage "清理了旧版Edge缓存"

echo 浏览器缓存清理完成!
pause
goto :MainMenu

:: 聊天软件缓存清理
:ChatCache
call :CreateLogDir
echo 正在清理聊天软件缓存...
call :LogMessage "开始清理聊天软件缓存"

:: 清理微信缓存
call :WechatClean
call :LogMessage "清理了微信缓存"

:: 清理QQ缓存
call :QQClean
call :LogMessage "清理了QQ缓存"

:: 清理TIM缓存
call :TIMClean
call :LogMessage "清理了TIM缓存"

:: 清理Discord缓存
set "USERPATH=%appdata%\discord\Cache"
call :DeleteFolder
set "USERPATH=%appdata%\discord\Code Cache"
call :DeleteFolder
set "USERPATH=%appdata%\discord\GPUCache"
call :DeleteFolder
set "USERPATH=%appdata%\discord\DawnCache"
call :DeleteFolder
set "USERPATH=%appdata%\discord\logs"
call :DeleteFolder
call :LogMessage "清理了Discord缓存"

echo 聊天软件缓存清理完成!
pause
goto :MainMenu

:: 媒体软件缓存清理
:MediaCache
call :CreateLogDir
echo 正在清理媒体软件缓存...
call :LogMessage "开始清理媒体软件缓存"

:: 网易云音乐
set "USERPATH=%localappdata%\Netease\CloudMusic\Cache"
call :DeleteFolder
set "USERPATH=%localappdata%\Netease\CloudMusic\Temp"
call :DeleteFolder
set "USERPATH=%localappdata%\Netease\CloudMusic\webapp91x64\Cache"
call :DeleteFolder
set "USERPATH=%localappdata%\Netease\CloudMusic\webapp91x64\Code Cache"
call :DeleteFolder
set "USERPATH=%localappdata%\Netease\CloudMusic\webapp91x64\GPUCache"
call :DeleteFolder
call :LogMessage "清理了网易云音乐缓存"

:: B站客户端
set "USERPATH=%appdata%\bilibili\Cache"
call :DeleteFolder
set "USERPATH=%appdata%\bilibili\Code Cache"
call :DeleteFolder
set "USERPATH=%appdata%\bilibili\GPUCache"
call :DeleteFolder
set "USERPATH=%appdata%\bilibili\DawnCache"
call :DeleteFolder
set "USERPATH=%appdata%\bilibili\logs"
call :DeleteFolder
call :LogMessage "清理了B站客户端缓存"

:: Adobe缓存
set "USERPATH=%localappdata%\Adobe\Common\Media Cache"
call :DeleteFolder
set "USERPATH=%appdata%\Adobe\Common\Media Cache"
call :DeleteFolder
call :LogMessage "清理了Adobe缓存"

echo 媒体软件缓存清理完成!
pause
goto :MainMenu

:: 系统组件清理
:SystemComp
call :CreateLogDir
echo 正在执行系统组件清理...
call :LogMessage "开始系统组件清理"

echo 正在清理WinSxs组件存储...
Dism /online /Cleanup-Image /StartComponentCleanup
call :LogMessage "执行了WinSxs组件清理"

echo 正在运行系统磁盘清理...
cleanmgr /sagerun:1
call :LogMessage "执行了系统磁盘清理"

echo 系统组件清理完成!
pause
goto :MainMenu

:: 全面清理
:FullClean
call :CreateLogDir
echo 开始全面清理...
call :LogMessage "开始执行全面清理"

call :SystemTemp
call :BrowserCache
call :ChatCache
call :MediaCache
call :SystemComp

echo 全面清理完成!
call :LogMessage "全面清理完成"
pause
goto :MainMenu

:: 微信清理子程序
:WechatClean
set "TENCENT_PATH=%userprofile%\Documents\WeChat Files"
for /d %%G in ("%TENCENT_PATH%\*") do (
    if exist "%%G\FileStorage" (
        set "USERPATH=%%G\FileStorage\Image"
        call :DeleteFolder
        set "USERPATH=%%G\FileStorage\Video"
        call :DeleteFolder
        set "USERPATH=%%G\FileStorage\CustomEmotion"
        call :DeleteFolder
        set "USERPATH=%%G\FileStorage\Sns"
        call :DeleteFolder
        set "USERPATH=%%G\FileStorage\Cache"
        call :DeleteFolder
        set "USERPATH=%%G\FileStorage\Temp"
        call :DeleteFolder
    )
)
:: 删除微信小程序组件
set "USERPATH=%appdata%\Tencent\WeChat\XPlugin"
call :DeleteFolder
exit /b

:: QQ清理子程序
:QQClean
:: 设置Tencent Files目录路径，清理qq图片
set "TENCENT_PATH=%userprofile%\Documents\Tencent Files"
:: 遍历Tencent Files目录下的文件夹
for /d %%G in ("%TENCENT_PATH%\*") do (
    :: 检查是否存在Image、Video、Audio文件夹
    if exist "%%G\Image" (
        set "USERPATH=%%G\Image"
        call :DeleteFolder
    )
    if exist "%%G\Video" (
        set "USERPATH=%%G\Video"
        call :DeleteFolder
    )
    if exist "%%G\Audio" (
        set "USERPATH=%%G\Audio"
        call :DeleteFolder
    )
)

:: 清理NTQQ组件
for /d %%G in ("%TENCENT_PATH%\*") do (
    if exist "%%G\TIM" (
        set "USERPATH=%%G\nt_qq"
        call :DeleteFolder
        set "USERPATH=%%G\GroupCollection"
        call :DeleteFolder
        set "USERPATH=%%G\MyCollection"
        call :DeleteFolder
        set "USERPATH=%%G\CloudRes"
        call :DeleteFolder
        set "USERPATH=%%G\AppWebCache"
        call :DeleteFolder
        set "USERPATH=%%G\RecommendFace"
        call :DeleteFolder
    )
)

:: 清理QQ其他组件
set "RoamingQQ_PATH=%appdata%\Tencent\QQ"
set "USERPATH=%RoamingQQ_PATH%\webkit_cache"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\Temp"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\STemp"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\TimwpReport"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\QQFace"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\PushHead"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\AuTemp"
call :DeleteFolder
set "USERPATH=%RoamingQQ_PATH%\HotFriendInfoRes"
call :DeleteFolder

set "USERPATH=%appdata%\Tencent\Logs"
call :DeleteFolder
set "USERPATH=%appdata%\Tencent\QQTempSys"
call :DeleteFolder

:: 清理QQ多余的组件
set "USERPATH=%appdata%\Tencent\QQMicroGameBoxTray"
call :DeleteFolder
set "USERPATH=%appdata%\Tencent\QQPCMgr"
call :DeleteFolder
set "USERPATH=%appdata%\Tencent\QQLive"
call :DeleteFolder
set "USERPATH=%appdata%\Tencent\QQDoctor"
call :DeleteFolder
exit /b

:: TIM清理子程序
:TIMClean
set "TIM_PATH=%appdata%\Tencent\TIM"
set "USERPATH=%TIM_PATH%\Temp"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\STemp"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\PushHead"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\QQFace"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\HotFriendInfoRes"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\TimwpReport"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\GroupHead"
call :DeleteFolder
set "USERPATH=%TIM_PATH%\DSBackGround"
call :DeleteFolder
exit /b

:: 删除文件夹函数
:DeleteFolder
if not exist "%USERPATH%" exit /b
echo 正在清理: %USERPATH%
:: 删除文件
del /f /s /q "%USERPATH%\*.*" >nul 2>&1
:: 切换目录
cd /d "%USERPATH%" 2>nul
:: 删除目录(如果仍然存在)
if exist "%USERPATH%" rd /s /q "%USERPATH%" >nul 2>&1
exit /b