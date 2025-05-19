#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e
# --- Configuration ---
xset dpms force off
BLUR_LEVEL="0x5"                                 # Sigma for Gaussian blur (0 for auto-radius, 5 for sigma)
TMP_SCREENSHOT_BLURRED="/tmp/screen_blurred.png" # Only one temp file needed

maim | magick - -blur "$BLUR_LEVEL" "$TMP_SCREENSHOT_BLURRED"

i3lock -i "$TMP_SCREENSHOT_BLURRED" -e -u

if [ -f "$TMP_SCREENSHOT_BLURRED" ]; then
  echo "Removing $TMP_SCREENSHOT_BLURRED"
  rm "$TMP_SCREENSHOT_BLURRED"
fi

echo "Script finished."
exit 0
