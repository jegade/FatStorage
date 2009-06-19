#/bin/bash

# Prefork-Engine für den Entwicklungsbetrieb
export CATALYST_ENGINE='HTTP::Prefork' 

export CATALYST_STATS=1

export CATALYST_DEBUG=1

# Entwicklungsspezifische Konfiguration laden
export CATALYST_CONFIG_LOCAL_SUFFIX='dev'

# Entwicklungserver mit Reload-Option, Keekalive und Debug-Option auf Port 3000 starten
script/fatstorage_server.pl -d -k -p 3001 -r
