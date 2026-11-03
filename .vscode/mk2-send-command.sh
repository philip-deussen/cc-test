#!/usr/bin/env bash

SERIAL_PORT="${1}"
MK2_COMMAND="${2}"

echo "Senden des Befehls '${MK2_COMMAND}' auf seriellem Port '${SERIAL_PORT}'"

# Für Befehlsübersicht siehe https://www.mikrocontroller.net/attachment/132663/techb_mysmartusb-mk2_de_en.pdf
# Der Link zur offiziellen Website zeigt beim MK2 auf eine neuere Beschreibung, die für eine neuere Firmware und
# ein verändertes Protokoll ausgelegt ist.

# MK2 nutzt 19200 Baud, 8N1 für die Einstellungen der Modi und sende Befehl
stty -F "${SERIAL_PORT}" 19200 cs8 -cstopb -parenb raw -echo -ixon -ixoff -crtscts && printf "${MK2_COMMAND}" > "${SERIAL_PORT}"