FROM ubuntu:14.04.4

#Install the required packages
RUN apt-get -qq update && \
        apt-get -qq -y install \
        python-dev \
        python-virtualenv \
        build-essential \
        libxslt1-dev \
        libxml2-dev \
        zlib1g-dev \
        git

ENV DATAPUSHER_HOME /usr/lib/ckan/datapusher

#Create a source directory
RUN mkdir -p $DATAPUSHER_HOME/src
#Switch to source directory
WORKDIR $DATAPUSHER_HOME/src
#Clone the source
RUN git clone -b stable https://github.com/ckan/datapusher.git

#Install the dependencies
WORKDIR datapusher
RUN pip install -r requirements.txt && \
        pip install -e .

EXPOSE 8800

#Run the DataPusher
CMD [ "python", "datapusher/main.py", "deployment/datapusher_settings.py"]
