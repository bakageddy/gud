#!/usr/bin/env sh

# eww get EWW_BATTERY | jq .'total_avg' | printf "%.0f"
printf "%.0f" "$(eww get EWW_BATTERY | jq .'total_avg')"
