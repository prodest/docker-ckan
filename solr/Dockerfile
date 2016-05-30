FROM solr:6.0.0

USER root 

RUN mkdir -p /opt/ckan-solr/scripts
COPY docker-entrypoint.sh /opt/ckan-solr/scripts
RUN chown -R $SOLR_USER:$SOLR_USER /opt/ckan-solr

USER $SOLR_USER

ENTRYPOINT ["/opt/ckan-solr/scripts/docker-entrypoint.sh"]
CMD ["solr-create-ckan"]

EXPOSE 8983
#VOLUME /opt/solr/server/solr
