# DOCKER IMAGE for ODOO

# build image

docker build -t senzil/odoo .

# Prepare for Production

You need specify some environment variables. Please see the environment file in this repository.

# Run Stack locally
Dockerfile of ODOO 13.0 with Adhoc Argentinian Localization from SENZIL Team


docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres
docker run -d --name aeroo adhoc/aeroo-docs
docker run -d -p 80:8069 --link db --link aeroo --name odoo senzil/odoo:13

OR 

docker-compose -d -c stack.yml odoo

# Special Mention
We want to congrat and to thank to @ingadhoc for its great work
