# docker-odoo
Dockerfile of ODOO 9.0 with Adhoc Argentinian Localization from SENZIL Team


docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres
docker run -d --name aerodocs adhoc/aeroo-docs
docker run -d -p 80:8069 --link db --link aerodocs --name odoo senzil/odoo:9