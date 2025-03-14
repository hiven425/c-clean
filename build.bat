@echo off
echo 正在将清理脚本打包为可执行文件...

:: 检查是否存在Iexpress工具
if not exist "%windir%\system32\iexpress.exe" (
    echo 错误: 找不到IExpress工具，无法创建EXE文件
    pause
    exit /b
)

:: 创建SED脚本
echo [Version] > clean_tool.SED
echo Class=IEXPRESS >> clean_tool.SED
echo SEDVersion=3 >> clean_tool.SED
echo [Options] >> clean_tool.SED
echo PackagePurpose=InstallApp >> clean_tool.SED
echo ShowInstallProgramWindow=0 >> clean_tool.SED
echo HideExtractAnimation=1 >> clean_tool.SED
echo UseLongFileName=1 >> clean_tool.SED
echo InsideCompressed=0 >> clean_tool.SED
echo CAB_FixedSize=0 >> clean_tool.SED
echo CAB_ResvCodeSigning=0 >> clean_tool.SED
echo RebootMode=N >> clean_tool.SED
echo InstallPrompt=%%InstallPrompt%% >> clean_tool.SED
echo DisplayLicense=%%DisplayLicense%% >> clean_tool.SED
echo FinishMessage=%%FinishMessage%% >> clean_tool.SED
echo TargetName=%%TargetName%% >> clean_tool.SED
echo FriendlyName=%%FriendlyName%% >> clean_tool.SED
echo AppLaunched=%%AppLaunched%% >> clean_tool.SED
echo PostInstallCmd=%%PostInstallCmd%% >> clean_tool.SED
echo AdminQuietInstCmd=%%AdminQuietInstCmd%% >> clean_tool.SED
echo UserQuietInstCmd=%%UserQuietInstCmd%% >> clean_tool.SED
echo SourceFiles=SourceFiles >> clean_tool.SED
echo [Strings] >> clean_tool.SED
echo InstallPrompt=你确定要运行Windows C盘清理工具吗? >> clean_tool.SED
echo DisplayLicense= >> clean_tool.SED
echo FinishMessage=Windows C盘清理工具已成功运行 >> clean_tool.SED
echo TargetName=%cd%\WindowsCCleaner.exe >> clean_tool.SED
echo FriendlyName=Windows C盘清理工具 >> clean_tool.SED
echo AppLaunched=cmd /c clean.bat >> clean_tool.SED
echo PostInstallCmd=^<None^> >> clean_tool.SED
echo AdminQuietInstCmd= >> clean_tool.SED
echo UserQuietInstCmd= >> clean_tool.SED
echo FILE0=clean.bat >> clean_tool.SED
echo [SourceFiles] >> clean_tool.SED
echo SourceFiles0=%cd% >> clean_tool.SED
echo [SourceFiles0] >> clean_tool.SED
echo %%FILE0%%= >> clean_tool.SED

:: 运行IExpress创建EXE
%windir%\system32\iexpress.exe /N clean_tool.SED

echo EXE文件创建完成!
echo 输出文件：%cd%\WindowsCCleaner.exe
pause 