FROM odoo:9
MAINTAINER Pablo González <pablodgonzalez@gmail.com>

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends\
    git \
    python-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-httplib2 \
    python-m2crypto \
    locales

RUN locale-gen en_US.UTF-8 && update-locale
RUN locale-gen es_AR.UTF-8 && update-locale
RUN echo 'LANG="en_US.UTF-8"' > /etc/default/locale
ENV LANG es_AR.UTF-8
ENV LANGUAGE es_AR:es:en_US:en
ENV LC_ALL es_AR.UTF-8

RUN mkdir -p /var/extra-addons \
    && git clone  -b 9.0 https://github.com/OCA/account-closing /var/extra-addons/account-closing \
    && git clone -b 9.0 https://github.com/ingadhoc/account-financial-tools /var/extra-addons/account-financial-tools \
    && git clone -b 9.0 https://github.com/ingadhoc/account-payment /var/extra-addons/account-payment \
    && git clone -b 9.0 https://github.com/ingadhoc/aeroo_reports /var/extra-addons/aeroo_reports \
    && git clone -b 9.0 https://github.com/OCA/bank-payment /var/extra-addons/bank-payment \
    && git clone -b 9.0 https://github.com/OCA/margin-analysis /var/extra-addons/margin-analysis \
    && git clone -b 9.0 https://github.com/ingadhoc/miscellaneous /var/extra-addons/miscellaneous \
    && git clone -b 8.0 https://github.com/ingadhoc/odoo-addons /var/extra-addons/odoo-addons \
    && git clone -b 9.0 https://github.com/ingadhoc/odoo-argentina /var/extra-addons/odoo-argentina \
    && git clone -b 9.0 https://github.com/OCA/partner-contact /var/extra-addons/partner-contact \
    && git clone -b 9.0 https://github.com/OCA/product-attribute /var/extra-addons/product-attribute \
    && git clone -b 9.0 https://github.com/OCA/sale-workflow /var/extra-addons/sale-workflow \
    && git clone -b 9.0 https://github.com/OCA/server-tools /var/extra-addons/server-tools \
    && git clone -b 9.0 https://github.com/OCA/stock-logistics-barcode /var/extra-addons/stock-logistics-barcode \
    && git clone -b 9.0 https://github.com/OCA/stock-logistics-tracking /var/extra-addons/stock-logistics-tracking \
    && git clone -b 9.0 https://github.com/OCA/stock-logistics-transport /var/extra-addons/stock-logistics-transport \
    && git clone -b 9.0 https://github.com/OCA/stock-logistics-warehouse /var/extra-addons/stock-logistics-warehouse \
    && git clone -b 9.0 https://github.com/OCA/stock-logistics-workflow /var/extra-addons/stock-logistics-workflow \
    && git clone -b 9.0 https://github.com/OCA/web /var/extra-addons/web \
    && git clone -b 9.0 https://github.com/OCA/webkit-tools /var/extra-addons/webkit-tools

RUN chown -R odoo /var/extra-addons \
    && pip install --upgrade pip setuptools openupgradelib \
    && pip install -r /var/extra-addons/odoo-argentina/requirements.txt \
    && pip install -r /var/extra-addons/partner-contact/requirements.txt \
    && pip install -r /var/extra-addons/server-tools/requirements.txt \
    && pip install -r /var/extra-addons/stock-logistics-barcode/requirements.txt \
    && pip install git+https://github.com/aeroo/aeroolib.git \
    && chown odoo /usr/local/lib/python2.7/dist-packages/pyafipws/

COPY ./conf/openerp-server.conf /etc/odoo/

USER odoo

CMD ["openerp-server"]