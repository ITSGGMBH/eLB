@ECHO OFF
Rem create .validator base folder
if not exist ".validator" (
    mkdir ".validator" 2>nul
)

Rem Download validator if not exists
if not exist ".validator/validator_cli.jar" (
    curl https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar -L -o .validator/validator_cli.jar
)

Rem run validation
@ECHO ON
java -jar ./.validator/validator_cli.jar .\Beispiele\** -version 4.0 -ig ./ -ig de.basisprofil.r4#1.4.0 %*
@PAUSE
