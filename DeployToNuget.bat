@ECHO OFF

REM Update Nuget
REM ============
nuget.exe update -self

REM Delete Any Artifacts
REM ====================
if exist build (
	rd /s/q build
)

mkdir build

REM Requests the API Key
REM ====================
SET /p NuGetApiKey= Please enter the project's NuGet API Key: 

SET package="src\Bumblebee.KendoUI\Bumblebee.KendoUI.csproj"

REM Create the Package
REM ==================
ECHO "Packing/Pushing project found here:  %package%."
nuget.exe pack -Build -OutputDirectory build %package% -Prop Configuration=Release

REM Push to Nuget 
REM =============
cd build

nuget.exe push Bumblebee.Automation.KendoUI.*.nupkg %NuGetApiKey% -Source https://www.nuget.org/api/v2/package
cd ..
