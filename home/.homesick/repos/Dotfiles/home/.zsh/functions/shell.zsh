# Kill all shell jobs running in the background.
killalljobs() {
    for pid in $( jobs -p ); do kill -9 $pid ; done ;
}

