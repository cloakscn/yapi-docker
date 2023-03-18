#!/bin/bash
case $TYPE in
    migrate)
        touch init.lock
        node vendors/server/app.js
    ;;
    *)
        find init.lock > /dev/null 2>&1
        INITLOCK=$(echo $?)
        if [ $INITLOCK = 1 ]; then
            node vendors/server/install.js
        fi
        node vendors/server/app.js
esac