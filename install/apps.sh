#!/bin/bash

set -xe

if ! [ -d /Applications/Anki.app ]; then
    ANKI_VERSION=2.1.3
    curl -Lo $HOME/.cache/anki-$ANKI_VERSION-mac.dmg \
        https://apps.ankiweb.net/downloads/current/anki-$ANKI_VERSION-mac.dmg
    open $HOME/.cache/anki-$ANKI_VERSION-mac.dmg
    sleep 2s
    cp -R /Volumes/Anki/Anki.app /Applications
    umount /Volumes/Anki
    echo "Open Anki, press the `sync` button and sign in"
fi
