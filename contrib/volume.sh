#!/usr/bin/env bash

# The script has a very simple interface, valid usages are as follows:
#
#     $ volume up
#     $ volume down
#     $ volume mute
#
function usage {
    cat <<EOF
volume - Volume Control (custom script)

Usage:
  volume CMD

Help Options:
  -h, --help                  Show help (this message)

Script Commands:
  up          Increase volume 5%
  down        Decrease volume 5%
  mute        Toggle mute/unmute volume state

EOF
}

# Scrape the volume level from the `pactl` output.
#
# That is, it will extract the first `64` from the following sample
# `pactl` output (without the '%' sign):
#
#     $ pactl get-sink-volume @DEFAULT_SINK@                                                                                                                          ⏎ ✹
#     Volume: front-left: 41944 /  64% / -11.63 dB,   front-right: 41944 /  64% / -11.63 dB
#             balance 0.00
#
# NOTE This is how to do it with `amixer` and withouth AWK:
#
#     $ amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
#
function get_current_volume_level {
    # TODO The small AWK code can be in a EOT block?
    pactl get-sink-volume @DEFAULT_SINK@ | awk 'BEGIN { FS = "/"; }; NR == 1 && match($2, /^\s*([0-9]+)%\s*/, res) { print res[1]; }'
}

# Determine whether sound is muted or not using `pactl`.
#
# NOTE This can be achieved with `amixer` as follows:
#
#     $ amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
#
function is_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep 'yes' > /dev/null
}

# Build a notification and send it to `dunst` using `dunstify` command.
#
# This only makes the notification show, no volume control will happen,
# the current volume will only be queried and used to draw a simple
# progress bar with drawing characters.
#
function send_notification {
    volume_level=$(get_current_volume_level)

    # Make the bar with the special drawing character
    volume_bar=$(seq -s "▂▂" $(($volume_level / 7)) | sed 's/[0-9]//g')

    # NOTE if the bar is too thick then can use the line character instead:
    #      bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')

    # Send the notification
    dunstify -i audio-volume-muted-blocking -t $notification_timeout -r $notification_id -u normal "    $volume_bar"
}


notification_timeout=800
notification_id=2593


case $1 in
    up)
        # Unmute in case it was muted (idempotent)
        pactl set-sink-mute @DEFAULT_SINK@ 0  # Unmute in case it was muted (idempotent)
        # Or with `amixer` use: amixer -D pulse set Master on > /dev/null

        # Up the volume (+ 5%)
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        # Or with `amixer` use: amixer -D pulse sset Master 5%+ > /dev/null

        send_notification
        ;;

    down)
        pactl set-sink-volume @DEFAULT_SINK@ -5%

        send_notification
        ;;

    mute)
        # Toggle mute
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        # Or with `amixer` use: amixer -D pulse set Master 1+ toggle > /dev/null

        if is_mute ; then
            dunstify -i audio-volume-muted -t $notification_timeout -r $notification_id -u normal "Mute"
        else
            send_notification
        fi
        ;;

    *)
        usage
        ;;
esac
