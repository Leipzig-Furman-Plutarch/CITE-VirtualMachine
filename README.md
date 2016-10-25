# Leipzig-Furman Collaboration: virtualMachine2016

A Vagrant virtual machine for running CITE/CTS services with data from the Leipzig-Furman collaboration. The VM runs Ubuntu-server/trusty, 64-bit version. This VM offers a testbed for the [Homer Multitext](http://homermultitext.org)'s implementation of CTS, which is a Java based servlet using an RDF database as a back-end.

There are other implementations of CTS, notably the [Capitains/Toolkit](https://libraries.io/github/Capitains/Toolkit) by Thibault Clérice of the University of Leipzig.  

## About CITE/CTS

- [About the CITE Architecture](http://cite-architecture.github.io/about/)
- [About CTS](http://cite-architecture.github.io/cts/)
- [About CTS URNs](http://cite-architecture.github.io/ctsurn/)

For discussion of the particular technologies implemented in this Virtual Machine, see below.

## Requirements

To use this Virtual Machine, you need to install two pieces of software:

- [VirtualBox](https://www.virtualbox.org)
- [Vagrant](https://www.vagrantup.com)

> **For Windows 10 users:** There is a known incompatibility between VirtualBox and Win10's networking. If you run into trouble, you might try downloading a recent [test build](https://www.virtualbox.org/wiki/Testbuilds) of VirtualBox.

## Initializing the Virtual Machine

These instructions assume familarity with the command-line environment and the very basics of Unix/Linux.

- Download and install [VirtualBox](https://www.virtualbox.org) 

- **Test VirtualBox by opening it on your machine.** Some Windows hardware require you manually to enable VT-x in the machine's firmware; see, for example [this page on the issue](http://www.howtogeek.com/213795/how-to-enable-intel-vt-x-in-your-computers-bios-or-uefi-firmware/). Every brand of hardware has its own method for doing this, and every inidivual model may be different. 

- Download and install [Vagrant](https://www.vagrantup.com).

- Clone this repository.

	- If you do not have [Git](https://git-scm.com) installed, you can [download the repository as a `.zip` file](https://github.com/Leipzig-Furman-Plutarch/virtualMachine2016/archive/master.zip)

	- If you do have [Git](https://git-scm.com): `cd ~/Desktop; git clone https://github.com/Leipzig-Furman-Plutarch/virtualMachine2016.git`

- In a Terminal, navigate into the resulting directory, `virtualMachine2016`, with, *e.g.* `cd ~/Desktop/virtualMachine2016`.

- Start the virtual machine with the terminal command `vagrant up`. The first time you do this, Vagrant will take many minutes downloading files, seting up a Linux virtual machine, and provisioning it. **Do not let your computer go to sleep during this process**. 

- When you are returned to the command-prompt, the Virtual Machine is ready and running. 

- You can stop it by navigating (on the command-line) to the `virtualmachine2016` directory and typing the command `vagrant halt`.

## Running: Using the Scripts

Once you have initialized the virtual machine, if you have stopped it with `vagrant halt`, you can re-start it with `vagrant up`. It will not take nearly as long to boot a second time. When it is running (you are returned to the command-prompt), you can log into it thus, from the 'virtualMachine2016' directory:

> `vagrant ssh`

There are a series of numbered scripts, which will walk you through the necessary steps. You can see them by navigating to their directory:

>  `cd /vagrant/scripts; ls -la` 

These will configure the CTS database and server, build data, load it, and start the CTS server.

These scripts are intended to constitute a step-by-step manual on using the various tools necesary to serve texts using the Homer Multitext's implementation of CTS. 

You should be able to run any of these scripts simply by typing their name and [ENTER] or [RETURN].

### 0. Configure the CS2 Servlet

> `0_Configure_CS2.sh`

This script navigates to `/vagrant/cs2` and uses [Gradle](http://gradle.org) to configure the CITE Servlet application (cs2). This only needs to be done once. As part of the configuration process, the script will run the CITE Servlet's unit tests; they will all fail. This is normal, since you haven't loaded any data yet.

### 1. Build the Test Data with CITE-Manager

> `1_Build_Test_Data.sh`

Uses CITE Manager to generated tabulated expressions of the texts in the text corpus, and then RDF expressions for loading into the Fuseki Database. The script points to a Gradle configuration file that can serve as an example of how to use CITE Manager to process other corpora.

### 2. Load the Test Data into the Database with `tdbloader2` 

> `2_Load_Test_Data_into_DB.sh`

Uses the utility `tdbloader2`, part of [the Apache Jena](https://jena.apache.org) package, to load a `.ttl` file into a database.

### 3. Test CS2/sparclcts

> `3_Test_CTS.sh`

Runs the Unit- and Integration-Tests for SparqlCTS, against the data you just loaded. This will confirm that the CTS service is working.

You can see the results of these tests by looking (from the **host** computer) at the file: 

> `virtualMachine2016/cs2/sparqlcts/build/reports/tests/index.html`. 

The test themselves are in these directories:

> `virtualMachine2016/cs2/sparqlcts/src/test/groovy/edu/holycross/shot/sparqlcts`

> `virtualMachine2016/cs2/sparqlcts/src/integr/groovy/edu/holycross/shot/sparqlcts`

### 4. Build the Demo Data with CITE-Manager

> `4_Build_Demo_Data.sh`

As above, with the test data, this processes a larger demonstration corpus with CITE Manager. This will take many minutes.

### 5. Load the Demo Data into the Database with `tdbloader2`

> `5_Load_Demo_Data_into_DB.sh`

As above, this loads the demo data into a database.

### 6. Run SparqlCTS

> `6_Run_SparqlCTS.sh`

See if it all works, and explore CTS. Run the script. Once Gradle has started everything up, on the **host** computer, navigate a browser to:

> `http:localhost:9090/sparqlcts`

Quit the server (back in the VM's command-line) with `control-c`.

### 7. Set up Apache2 for Fancy Tricks

> `7_Set_Up_Apache2.sh`

As initially configured, there are two ways to access the CTS Service running on the Virtual Machine.

1. From the host computer, at  http://192.168.33.10:8080 .
2. From the host computer, at http://localhost:9090 .

With a little configuration of the Apache2 server in the VM, we can offer somewhat easier access. The script `7_Set_Up_Apache2.sh` does the following:

- copies a configuration file to `/etc/apache2/sites-available`
- loads that configuration with the utility `a2ensite`
- restarts Apache2 with the utility `apachectl`.

The original configuration file is in `/vagrant/scripts/apache2-cite-proxy.conf`.

Once it has been loaded, and Apache2 restarted, you can access the CTS Server, with all of its features at:

>  `http://192.168.33.10/cts`

You can also grab a text passage directly from the server at, *e.g.*:

>  `http://192.168.33.10/cts/gp/urn:cts:greekLit:tlg0012.tlg001.fuPers:1.1-1.10`

(Where `/gp/` stands for `getPassage`.) Similarly, you can get all valid citations for a define URN with, *e.g.*:

>  `http://192.168.33.10/cts/gvr/urn:cts:greekLit:tlg0012.tlg001.fuPers:1`

(Where `/gvr/` stands for `getValidReff`.)

This might be useful for other applications drawing on CTS texts.

## General Instructions for the Virtual Machine

- `vagrant up` starts the machine.
- `vagrant ssh` (from the `virtualMachine2016` directory) logs into the machine. `logout` exits the machine.
- When you are logged into the virtual machine, `logout` returns you to the host computer.
- `vagrant halt` stops the virtual machine.
- You can destroy the virtual machine with `vagrant destroy`. After doing that, you can re-created it with `vagrant up`, at which point it will download and provision a fresh new instance of it.
- If you want to start over completely cleanly, you should remove the directories checked out from GitHub by the VM:

	> In `virtualmachine2016`: 
	
	> `sudo rm -r cite_test_ttl data citemgr cs2 cts-demo-corpus`
	
	> *Be careful!* `rm -r` is a destructive command; be sure you are in the right place, and type it correctly.



- After you have destroyed a VM, `vagrant up` will rebuild it and re-provision it anew. Run the numbered scripts again.

## Where Things Are

The `virtualMachine2016` directory, where this `README.md` file is, is mapped in the virtual machine to `/vagrant`.

**You can access everything in (the VM's) `/vagrant/` directory from your host computer, at `.../virtualMachine2016/`.

### Contents of `/vagrant`

- `scripts`. Scripts and configuration files for building a working CTS service with data. 
- `citemgr`. A utility for processing XML files into tabular format and RDF.
- `cs2`. The servlet package that includes SparqlCTS, the Homermultitext's implementation of CTS.
- `cite_test_ttl`. A corpus of data used for testing the functionality of SparqlCTS.
- `cts-demo-corpus`. A corpus of texts in Greek, Latin, and English for introducing CTS.
- `cts-corpus-template`. A minimal corpus, intended as the basis for new corpora.
- `data`. A convenient place to put `.ttl` files, because generating them anew is tedious.

## Overview of the Technologies

CS2 (CITE Servlet v.2) is a [Java servlet](http://docs.oracle.com/javaee/6/tutorial/doc/bnafd.html). Its code is written in [Apache Groovy](http://groovy-lang.org), which sells itself as "a powerful, optionally typed and dynamic language, with static-typing and static compilation capabilities, for the Java platform aimed at improving developer productivity thanks to a concise, familiar and easy to learn syntax."

CS2 is managed by [Gradle](https://en.wikipedia.org/wiki/Gradle), "an open source build automation system that builds upon the concepts of Apache Ant and Apache Maven and introduces a Groovy-based domain-specific language (DSL) instead of the XML form used by Apache Maven of declaring the project configuration.[2] Gradle uses a directed acyclic graph ("DAG") to determine the order in which tasks can be run."

The datastore for SparqlCTS is a [TDB store](https://jena.apache.org/documentation/tdb/index.html). From the documentation, "TDB is a component of Jena for RDF storage and query." The data is served to SparqlCTS by [Fuseki](https://jena.apache.org/documentation/fuseki2/index.html), a SPARQL server.

The texts in the corpora are [TEI-P5](http://www.tei-c.org/index.xml) validated XML. They are cataloged by TextInventory and CitationConfig files that validate to protocol-specific RelaxNG schemas. CTS *does not assume or require* TEI-XML; but all sample data provided in this Virtual Machine uses this scholarly standard.

CITE Manager is another Gradle project that processes XML texts into tabular and RDF expressions. CTS's data-model, "an ordered hierarchy of citation objects", makes this possible. 

### Misc. Notes

If you reconfigure the Fuseki DB config (`/cs2/fuseki/config-template.ttl`), you need to do the following:

- Delete the following directories (they will be rebuilt automatically): 
	- `/cts2/fuseki/fusekibase/system`
	- `/cts2/fuseki/fusekibase/system_files`
- Re-run `gradle configure` (from `/cs2/`).
