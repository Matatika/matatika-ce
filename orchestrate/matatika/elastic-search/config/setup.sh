#!/bin/bash

[[ -z "$ES_PATH_CONF" ]] && { echo "Error: ES_PATH_CONF not found in env"; exit 1; }
[[ -z "$MATATIKA_ES_BASE_URI" ]] && { echo "Error: MATATIKA_ES_BASE_URI not found in env"; exit 1; }
[[ -z "$MATATIKA_ES_ELASTIC_PASSWORD" ]] && { echo "Error: MATATIKA_ES_ELASTIC_PASSWORD not found in env"; exit 1; }

# for some reason even when port 9200 is open Elasticsearch is unable to be accessed as authentication fails
# a few seconds later it works
until $(curl -sSf -XGET --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD "${MATATIKA_ES_BASE_URI}/_cluster/health?wait_for_status=yellow&timeout=1s" > /dev/null); do
    printf 'AUTHENTICATION ERROR DUE TO X-PACK, trying again in 5 seconds \n'
    sleep 5
done


echo Initiating Elasticsearch Custom Index ${MATATIKA_ES_BASE_URI}
# move to the directory of this setup script
cd "$(dirname "$0")"


echo "-------------------"
echo "INDEX CONFIGURATION"
echo "-------------------"
#
# create a new 'datasets' index
#
if curl -s --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD --output /dev/null --silent --head --fail "${MATATIKA_ES_BASE_URI}/datasets"; then
  echo "datasets index already exists"
else
    echo "Creating datasets index"
    cat es_datasets_index_config.json
    #curl -v --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD -XDELETE "${MATATIKA_ES_BASE_URI}/datasets"
    curl -s --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD -XPUT "${MATATIKA_ES_BASE_URI}/datasets?pretty" -H 'Content-Type: application/json' -d @es_datasets_index_config.json
fi
#
# create a new 'profiles_datasets_likes' index
#
if curl -s --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD --output /dev/null --silent --head --fail "${MATATIKA_ES_BASE_URI}/profiles_datasets_likes"; then
  echo "profiles_datasets_likes index already exists"
else
    echo "Creating profiles_datasets_likes index"
    cat es_profiles_datasets_likes_index_config.json
    #curl -v --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD -XDELETE "${MATATIKA_ES_BASE_URI}/profiles_datasets_likes"
    curl -s --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD -XPUT "${MATATIKA_ES_BASE_URI}/profiles_datasets_likes?pretty" -H 'Content-Type: application/json' -d @es_profiles_datasets_likes_index_config.json
fi
#
# Update the default logstash-policy
#
echo "Updating the default logstash-policy"
cat es_logstash_policy_config.json
curl -s --cacert $ES_PATH_CONF/certs/ca/ca.crt --user elastic:$MATATIKA_ES_ELASTIC_PASSWORD --output /dev/null -XPUT "${MATATIKA_ES_BASE_URI}/_ilm/policy/logstash-policy" -H 'Content-Type: application/json' -d @es_logstash_policy_config.json
