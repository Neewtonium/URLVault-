#!/usr/bin/env bash
# URLVault CLI - Single-folder version
# Author: Newton Otieno Ojwang

set -euo pipefail

# ------------------ Configuration ------------------
PROJECT_DIR="$(pwd)"
ARCHIVE="${PROJECT_DIR}/web_archive.tar.gz"
TEMP_DIR="${PROJECT_DIR}/tmp_fetch"
LOG_FILE="${PROJECT_DIR}/fetch.log"

# Socials
SOC_LINKEDIN="https://www.linkedin.com/in/newton-ojwang-19b2262a8"
SOC_GITHUB="https://github.com/Neewtonium"
SOC_WHATSAPP="+254796763023"
SOC_YOUTUBE="https://youtube.com/@neewtonium?si=RDBlywA-IL5JHnoW"

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
CYAN="\033[0;36m"
RESET="\033[0m"

# ------------------ Helpers ------------------
cleanup() { [ -d "$TEMP_DIR" ] && rm -rf "$TEMP_DIR"; }
trap cleanup EXIT
timestamp_now() { date +"%Y-%m-%d %H:%M:%S"; }
make_timestamp_fname() { date +"%Y-%m-%d_%H-%M-%S"; }

mkdir -p "$TEMP_DIR"
touch "$LOG_FILE"

# ------------------ Banner ------------------
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}          URLVault CLI v1.0             ${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo -e "${YELLOW}Fetch URLs, archive snapshots, track integrity.${RESET}"
echo

# ------------------ URL Input ------------------
if [ $# -gt 0 ]; then
  URLS=( "$@" )
else
  echo -e "${GREEN}Enter URLs (space-separated):${RESET}"
  read -r -a URLS
fi

if [ "${#URLS[@]}" -eq 0 ]; then
  echo -e "${RED}No URLs provided. Exiting.${RESET}"
  exit 1
fi

# ------------------ Restore archive ------------------
if [ -f "$ARCHIVE" ] && [ -s "$ARCHIVE" ]; then
  tar -xzf "$ARCHIVE" -C "$TEMP_DIR" 2>/dev/null || echo -e "${YELLOW}Starting fresh vault.${RESET}"
fi

# ------------------ Fetch loop ------------------
for URL in "${URLS[@]}"; do
  TS_FNAME=$(make_timestamp_fname)
  OUTFILE="${TEMP_DIR}/${TS_FNAME}.txt"
  echo -e "${YELLOW}Fetching:${RESET} ${URL}"

  if curl -sS -f --location --max-time 30 "${URL}" -o "${OUTFILE}"; then
    LOG_LINE="[$(timestamp_now)] SUCCESS ${URL} -> ${TS_FNAME}.txt"
    echo -e "${GREEN}[SUCCESS]${RESET} ${URL}"
    echo "${LOG_LINE}" | tee -a "$LOG_FILE"
    if command -v sha256sum >/dev/null 2>&1; then
      sha256sum "${OUTFILE}" >> "${TEMP_DIR}/hashes.sha256"
    else
      openssl dgst -sha256 "${OUTFILE}" >> "${TEMP_DIR}/hashes.sha256"
    fi
  else
    LOG_LINE="[$(timestamp_now)] FAIL ${URL}"
    echo -e "${RED}[FAIL]${RESET} ${URL}"
    echo "${LOG_LINE}" | tee -a "$LOG_FILE"
    [ -f "${OUTFILE}" ] && rm -f "${OUTFILE}"
  fi
done

# ------------------ Repack archive ------------------
TMP_ARCHIVE="${PROJECT_DIR}/web_archive.tmp.tar.gz"
tar -czf "$TMP_ARCHIVE" -C "$TEMP_DIR" .
mv -f "$TMP_ARCHIVE" "$ARCHIVE"

# ------------------ Cleanup ------------------
rm -rf "$TEMP_DIR"

# ------------------ Footer / Socials ------------------
echo
echo -e "${BLUE}Vault updated successfully.${RESET}"
echo -e "${YELLOW}Logs:${RESET} ${LOG_FILE}"
echo
echo -e "${BLUE}Connect / Verify:${RESET}"
echo -e "${GREEN}LinkedIn:${RESET} ${SOC_LINKEDIN}"
echo -e "${GREEN}GitHub:${RESET}   ${SOC_GITHUB}"
echo -e "${GREEN}WhatsApp:${RESET}  ${SOC_WHATSAPP}"
echo -e "${GREEN}YouTube:${RESET}   ${SOC_YOUTUBE}"
