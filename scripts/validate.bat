@ECHO OFF
Rem Determine repo root (one level above this script)
SET "ROOT=%~dp0.."

Rem Create .validator base folder
if not exist "%ROOT%\.validator" (
    mkdir "%ROOT%\.validator" 2>nul
)

Rem Download validator if not exists
if not exist "%ROOT%\.validator\validator_cli.jar" (
    curl https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar -L -o "%ROOT%\.validator\validator_cli.jar"
)

Rem Run validation
@ECHO ON
java -Dfile.encoding=UTF-8 -jar "%ROOT%\.validator\validator_cli.jar" "%ROOT%\Beispiele\**" -version 4.0 -ig "%ROOT%" -ig de.basisprofil.r4#1.5.4 %*
@PAUSE
