FROM ubuntu:14.04.4

ENV CKAN_HOME /usr/lib/ckan/default

RUN apt-get -qq update && \
        apt-get -qq -y install \
        python-dev \
        libpq-dev \
        python-pip \
        python-virtualenv \
        git-core

RUN mkdir -p /usr/lib/ckan/default && \
        virtualenv --no-site-packages /usr/lib/ckan/default

WORKDIR $CKAN_HOME
RUN pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.5.2#egg=ckan' && \
        pip install -r $CKAN_HOME/src/ckan/requirements.txt && \
        mkdir -p /etc/ckan/default && \ 
        ln -s $CKAN_HOME/src/ckan/who.ini /etc/ckan/default/who.ini

COPY docker-entrypoint.sh /

EXPOSE 5000

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ckan"]
