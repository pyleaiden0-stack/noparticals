@echo off
title Building No Particles mod
echo.
echo === Step 1: checking Java 21 ===
where java >nul 2>nul
if errorlevel 1 (
  echo Java not found, installing it...
  winget install -e --id EclipseAdoptium.Temurin.21.JDK --accept-package-agreements --accept-source-agreements
  echo.
  echo Java installed. CLOSE this window and double-click build.bat again.
  pause
  exit /b
)
echo === Step 2: checking Gradle ===
where gradle >nul 2>nul
if errorlevel 1 (
  echo Gradle not found, installing it...
  winget install -e --id Gradle.Gradle --accept-package-agreements --accept-source-agreements
  echo.
  echo Gradle installed. CLOSE this window and double-click build.bat again.
  pause
  exit /b
)
echo === Step 3: building the mod (first time takes a few minutes) ===
call gradle build
if errorlevel 1 (
  echo.
  echo BUILD FAILED. Take a screenshot of the red error above and send it to Claude.
  pause
  exit /b
)
if not exist MY-MOD-JAR mkdir MY-MOD-JAR
copy /Y build\libs\noparticles-*.jar MY-MOD-JAR\ >nul
del /Q MY-MOD-JAR\*-sources.jar >nul 2>nul
echo.
echo DONE! Your .jar is in the MY-MOD-JAR folder. Put it in .minecraft\mods
start "" MY-MOD-JAR
pause
