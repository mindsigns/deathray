#!/bin/sh
cd `dirname $0`
exec erl -mnesia dir '"Deathray.db"' -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -s reloader -s deathray -s watchman start
