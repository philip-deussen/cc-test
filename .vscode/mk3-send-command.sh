#!/usr/bin/env bash

SERIAL_PORT="${1}"
MK3_COMMAND="${2}"

echo "Senden des Befehls '${MK3_COMMAND}' auf seriellem Port '${SERIAL_PORT}'"

# MK3 nutzt 500000 Baud, 8N1 für die Einstellungen der Modi
# Siehe https://shop.myavr.de/index.php?ws=download_file.ws.php&dlid=133&filename=produkte/mysmartusb_mk3/techb_mysmartusb-mk3_de_en.pdf
stty -F "${SERIAL_PORT}" 500000 cs8 -cstopb -parenb

# Sende Befehl zum Wechsel in den Datenmodus
echo "${MK3_COMMAND}" > "${SERIAL_PORT}"

# Return value des MK3
RETURN_VALUE=$(cat -v < "${SERIAL_PORT}")

# Prüfe, ob empfangener Wert 'ok' ist, andernfalls error
if [["${RETURN_VALUE}" != 'ok']]; then
    echo "MK3 kann Befehl nicht verarbeiten. Prüfen Sie die Verbindung."
    exit 1;
fi;