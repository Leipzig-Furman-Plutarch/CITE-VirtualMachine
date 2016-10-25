#!/usr/bin/env /bin/bash

echo "-----------------------------------"
echo "Navigating to cs2/sparqlcts…"
echo ""

cd /vagrant/cs2/sparqlcts

echo "-----------------------------------"
echo "When you run the test, if all goes well, the test will conclude with the words 'INFO  Cleaning up Shiro Environment'. At this point, you will need to type control-c to quit Gradle. The tests will take several minutes to conclude."
echo ""

read -p "Press [ENTER] to start the integration tests. When you see 'Cleaning up Shiro Environment' type control-c to quit."

echo ""

gradle farmIntegrationTest

echo "-----------------------------------"
echo "Done!"



