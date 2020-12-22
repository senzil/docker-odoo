FROM adhoc/odoo-ce:13.0

LABEL maintainer="Pablo González <pablodgonzalez@gmail.com>"

# Add other dependencies
# ligado a esto de aca https://github.com/pysimplesoap/pysimplesoap/pull/187#issuecomment-651193880 y este commit  https://github.com/ingadhoc/odoo-argentina/commit/13d431883c5e33a1f679d0ec537cf973723453c8
# dejamos de usar stable_py3k

USER root
RUN apt-get update \
    && apt-get install -y \
    apt-utils \
    build-essential \
    python-dev \
    swig  \
    libffi-dev  \
    libssl-dev  \
    python-m2crypto  \
    python-httplib2 \
    libcups2-dev \
    # pip dependencies that require build deps
    && python -m pip install --upgrade pip \
    && sudo -H -u odoo pip install --user --no-cache-dir pycups pyOpenSSL M2Crypto httplib2>=0.7 git+https://github.com/pysimplesoap/pysimplesoap@a330d9c4af1b007fe1436f979ff0b9f66613136e \
    # purge
    && apt-get purge -yqq build-essential '*-dev' make || true \
    && apt-get -yqq autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# fix 'dh key too small' error https://stackoverflow.com/questions/38015537/python-requests-exceptions-sslerror-dh-key-too-small
RUN sed  -i "s/CipherString = DEFAULT@SECLEVEL=2/#CipherString = DEFAULT@SECLEVEL=2/" /etc/ssl/openssl.cnf

USER odoo

# Add new entrypoints and configs
# COPY conf/entrypoint.d/* $RESOURCES/entrypoint.d/
# COPY conf/conf.d/* $RESOURCES/conf.d/
COPY conf/resources/* $RESOURCES/

# Aggregate new repositories of this image
RUN autoaggregate --config "$RESOURCES/repos.yml" --install --output $SOURCES/repositories

CMD ["odoo", "-i", "init"]