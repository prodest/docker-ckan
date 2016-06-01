FROM ubuntu:14.04.4

# Install required packages
RUN apt-get -qq update && \
        apt-get -qq -y install \
        python-dev \
        libpq-dev \
        python-pip \
        python-virtualenv \
        git-core \
        wget

ENV CKAN_HOME /usr/lib/ckan/default
ENV CKAN_CONFIG /etc/ckan/default
ENV CONFIG /etc/ckan/default/ckan.ini
ENV CONFIG_OPTIONS="custom-options.ini"

# Create directories & virtual env for CKAN
RUN mkdir -p $CKAN_HOME && \
        virtualenv --no-site-packages $CKAN_HOME

# Install ckan and create directories for CKAN config 
WORKDIR $CKAN_HOME
RUN pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.5.2#egg=ckan' && \
        pip install -r $CKAN_HOME/src/ckan/requirements.txt && \
        mkdir -p $CKAN_CONFIG && \ 
        ln -s $CKAN_HOME/src/ckan/who.ini $CKAN_CONFIG/who.ini

# Copy custom configurations
COPY config/$CONFIG_OPTIONS $CKAN_CONFIG/$CONFIG_OPTIONS

# Copy scripts
COPY scripts /opt/docker-ckan/scripts
RUN chmod -R u+x /opt/docker-ckan/scripts
ENV PATH /opt/docker-ckan/scripts:$PATH

EXPOSE 5000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["ckan"]
