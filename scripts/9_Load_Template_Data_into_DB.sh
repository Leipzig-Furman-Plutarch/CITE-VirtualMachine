#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigate to where Gradle/Fuseki stores data files, specifically the 'cts' data…"
echo ""

cd /vagrant/cs2/fuseki/fusekibase/databases/cts

echo "-----------------------------------"
echo "Remove anything there, since we are loading new data…"
echo ""

rm *

echo "-----------------------------------"
echo "Use the 'tdbloader2' utility from Apache Jena to load our 'cts-template.ttl' file into a TDB Database…"
echo ""

/usr/bin/jena/bin/tdbloader2 --loc /vagrant/cs2/fuseki/fusekibase/databases/cts /vagrant/data/cts-template.ttl

echo "-----------------------------------"
echo "Done! The CTS Template data has been loaded."
echo "Re-run the scrdipt '6_Run SparqlCTS.sh' to configure the service and run it with the new data."



