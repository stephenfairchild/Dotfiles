#!/bin/sh

killall polybar

polybar topbar -c .topbar &
polybar bottombar -c .bottombar

