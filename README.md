# Homer Multitext CITE/CTS: virtualMachine2017

> **N.b.** This Virtual Machine has been completely redone as of April, 2017. This README document may still be catching up with the changes. The instructions through "Intitializing…" are accurate. There will be some additions to the descriptions of technologies, and the outline of the contents of the VM need to be updated.

A Vagrant virtual machine for running CITE/CTS services for identification and retrieval of textual, image, and other data by means of machine-actional URN citations. The VM runs Ubuntu-server/trusty, 64-bit version. This VM offers a testbed for the [Homer Multitext](http://homermultitext.org)'s implementation of CTS, which is a Java based servlet using an RDF database as a back-end.

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

- **Test VirtualBox by opening it on your machine.** Some Windows hardware require you manually to enable VT-x in the machine's firmware; see, for example [this page on the issue](http://www.howtogeek.com/213795/how-to-enable-intel-vt-x-in-your-computers-bios-or-uefi-firmware/). Every brand of hardware has its own method for doing this, and every individual model may be different. 

- Download and install [Vagrant](https://www.vagrantup.com).

- Clone this repository.

	- If you do not have [Git](https://git-scm.com) installed, you can [download the repository as a `.zip` file](https://github.com/Leipzig-Furman-Plutarch/virtualMachine2017/archive/master.zip)

	- If you do have [Git](https://git-scm.com): `cd ~/Desktop; git clone https://github.com/Leipzig-Furman-Plutarch/virtualMachine2017.git`

- In a Terminal, navigate into the resulting directory, `virtualMachine2017`, with, *e.g.* `cd ~/Desktop/virtualMachine2017`.

- Start the virtual machine with the terminal command `vagrant up`. The first time you do this, Vagrant will take many minutes downloading files, seting up a Linux virtual machine, and provisioning it. **Do not let your computer go to sleep during this process**. 

- **It will take a long time.** The configuration process downloads a number of libraries and a lot of data. It also processed a CITE library of 24,000,000 RDF statements into a `tdb` database; this takes quite a while.

- When you are returned to the command-prompt, the Virtual Machine is ready and running. 

- You can stop it by navigating (on the command-line) to the `virtualmachine2017` directory and typing the command `vagrant halt`.

## Exploring the Virtual Machine

Once you have initialized the virtual machine, if you have stopped it with `vagrant halt`, you can re-start it with `vagrant up`. It will not take nearly as long to boot a second time. When it is running (you are returned to the command-prompt), you can log into it thus, from the 'virtualMachine2017' directory:

> `vagrant ssh`

When your VM and the CITE/CTS services are running, you can explore some links by going (on your **host** computer) to http://192.168.33.10.


## General Instructions for the Virtual Machine

- `vagrant up` starts the machine.
- `vagrant ssh` (from the `virtualMachine2017` directory) logs into the machine. `logout` exits the machine.
- When you are logged into the virtual machine, `logout` returns you to the host computer.
- `vagrant halt` stops the virtual machine.
- To start from scratch, be sure to run `vagrant halt`, then simply delete the `virtualMachine2017` directory, clone it anew, and start over.

## Where Things Are

The `virtualMachine2017` directory, where this `README.md` file is, is mapped in the virtual machine to `/vagrant`.

**You can access everything in (the VM's) `/vagrant/` directory from your host computer, at `.../virtualMachine2017/`.

## Overview of the Technologies

CS2 (CITE Servlet v.2) is a [Java servlet](http://docs.oracle.com/javaee/6/tutorial/doc/bnafd.html). Its code is written in [Apache Groovy](http://groovy-lang.org), which sells itself as "a powerful, optionally typed and dynamic language, with static-typing and static compilation capabilities, for the Java platform aimed at improving developer productivity thanks to a concise, familiar and easy to learn syntax."

CS2 is managed by [Gradle](https://en.wikipedia.org/wiki/Gradle), "an open source build automation system that builds upon the concepts of Apache Ant and Apache Maven and introduces a Groovy-based domain-specific language (DSL) instead of the XML form used by Apache Maven of declaring the project configuration.[2] Gradle uses a directed acyclic graph ("DAG") to determine the order in which tasks can be run."

The datastore for SparqlCTS is a [TDB store](https://jena.apache.org/documentation/tdb/index.html). From the documentation, "TDB is a component of Jena for RDF storage and query." The data is served to SparqlCTS by [Fuseki](https://jena.apache.org/documentation/fuseki2/index.html), a SPARQL server.

The texts in the corpora are [TEI-P5](http://www.tei-c.org/index.xml) validated XML. They are cataloged by TextInventory and CitationConfig files that validate to protocol-specific RelaxNG schemas. CTS *does not assume or require* TEI-XML; but all sample data provided in this Virtual Machine uses this scholarly standard.

CITE Manager is another Gradle project that processes XML texts into tabular and RDF expressions. CTS's data-model, "an ordered hierarchy of citation objects", makes this possible. 
