# https://unix.stackexchange.com/a/473789

# Produces "21 days", for example
uptime_formatted="up: $(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)"

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %e-%b-%Y %H:%M")

# Get the Linux version but remove the "-1-ARCH" part
kernel_version="kernel: $(uname -r | cut -d '-' -f1)"

# Returns the battery capacity
battery_capacity="bat: $(cat /sys/class/power_supply/BAT1/capacity)%"

# Returns the battery status if available
battery_status="$(cat /sys/class/power_supply/BAT1/status)"

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo "$uptime_formatted ↑ || $kernel_version 🐧 || $battery_capacity 🔋$battery_status || $date_formatted"

