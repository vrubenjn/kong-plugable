#!/bin/sh

if [ ! -f /tmp/first_run ]; then
    while ! pg_isready -h ${KONG_PG_HOST} -p ${KONG_PG_PORT} > /dev/null 2> /dev/null; do
        echo "Waiting for database ${KONG_PG_HOST}:${KONG_PG_PORT}"
        sleep 2
    done

    plugins=$(echo "${KONG_PLUGINS}" | tr "," "\n")
    for plugin in $plugins
    do
        if [ $plugin != "bundled" ]
        then
            echo "Installing plugin ${plugin}"
            luarocks install ${plugin}
        fi
    done

    kong migrations bootstrap

    touch /tmp/first_run
fi

kong migrations up

kong migrations finish

/docker-entrypoint.sh $@
