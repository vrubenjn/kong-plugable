# Kong-Plugable

Is a Kong official image's based that add a wait for a postgres to start and run migrations setup and also use ```KOKG_PLUGINS``` environment variable to install lua rocks avaliable on [ http://luarocks.org ]

For instructions about base image go to [ https://hub.docker.com/_/kong ]

For example you can use a plugin developed for kong ```oauth2-acl``` avaliable on [ https://luarocks.org/modules/vrubenjn/oauth2-acl ] by just setting ```KOKG_PLUGINS=bundled,oauth2-acl```. The image on first run runs ```luarocks install oauth2-acl``` to make plugin avaliable for Kong.

See next example for details.

## Full docker-compose example

```
version: '3'
services:
  db:
    image: postgres:11-alpine
    environment:
      - POSTGRES_DB=database
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
  gw:
    image: vrubenjn/kong-plugable
    environment:
      - KONG_PLUGINS=bundled,oauth2-acl
      - KONG_PG_HOST=db
      - KONG_PG_PORT=5432
      - KONG_PG_DATABASE=database
      - KONG_PG_SCHEMA=kong
      - KONG_PG_USER=user
      - KONG_PG_PASSWORD=password
    ports:
      - 8000:8000
      - 8443:8443
```