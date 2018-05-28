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
nuget.exe setApiKey %NuGetApiKey%

SET package="src\Bumblebee.KendoUI\Bumblebee.KendoUI.csproj"

REM Create the Package
REM ==================
ECHO "Restoring project found here:  %package%."
nuget.exe restore %package%

ECHO "Packing/Pushing project found here:  %package%."
dotnet build %package% -c Release
dotnet pack %package% --no-build -o ..\..\build -c Release

REM Push to Nuget 
REM =============
cd build
dotnet nuget push *.nupkg -s https://api.nuget.org/v3/index.json
cd ..