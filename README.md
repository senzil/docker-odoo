# docker-odoo
Dockerfile of ODOO 9.0 with Adhoc Argentinian Localization from SENZIL Team


docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres
docker run -d -p 8069:8069 --link db --name odoo senzil/odoo:9