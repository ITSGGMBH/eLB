#!/usr/bin/env bash
# Validate eLB FHIR profiles and examples against the de.basisprofil.r4 IG.
# Linux/macOS counterpart of validate.bat.

set -euo pipefail

# Repo / IG root (one level above this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

VALIDATOR_DIR="${ROOT}/.validator"
VALIDATOR_JAR="${VALIDATOR_DIR}/validator_cli.jar"
VALIDATOR_URL="https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar"

# Create .validator folder if missing
mkdir -p "${VALIDATOR_DIR}"

# Download validator if not present
if [ ! -f "${VALIDATOR_JAR}" ]; then
    echo "Lade FHIR-Validator nach ${VALIDATOR_JAR} ..."
    curl --fail --location --output "${VALIDATOR_JAR}" "${VALIDATOR_URL}"
fi

# Run validation
java -Dfile.encoding=UTF-8 -jar "${VALIDATOR_JAR}" \
    "${ROOT}/Beispiele" \
    -version 4.0 \
    -ig "${ROOT}" \
    -ig de.basisprofil.r4#1.5.4 \
    "$@"
