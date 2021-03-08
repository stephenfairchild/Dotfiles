# Set the light on the keyboard to the brightness of the passed in argument. 10
# works pretty nice.
setKeyboardLight() {
    dbus-send --system --type=method_call  --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:$1
}

# Set the light on the keyboard to the brightness of the passed in argument. 300 is
# a nice high brightness. 50 is fairly good for a low brightness.
changeBacklight() {
   echo $1 > /sys/class/backlight/intel_backlight/brightness
}


