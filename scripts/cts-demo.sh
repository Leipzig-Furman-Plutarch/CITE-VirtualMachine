#!/usr/bin/env /bin/bash

cd /vagrant/citemgr
gradle clean
gradle -Pproj=cts-demo.gradle projects:ctsttl
cp /vagrant/citemgr/projects/build/ttl/cts.ttl /vagrant/data/cts-demo.ttl
