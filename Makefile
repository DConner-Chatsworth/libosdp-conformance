# libosdp-conformance top level make file

# This makes the RS-485 version.  To make the TLS version,
# you need to explicitly do "make osdp-tls"

# Makefile for libosdp

all:
	(cd src-lib; make all; cd ..)
	(cd src-485; make all; cd ..)
	(cd src-ui; make all; cd ..)

osdp-tls:	release
	(cd src-tls; make all; cd ..)
	(cd src-tls; make build; cd ..)
	(cd src-ui; make build-tls; cd ..)
	rm -f release-osdp-conformance.tgz
	tar czvf release-osdp-conformance.tgz opt/*

clean:
	(cd src-lib; make clean; cd ..)
	(cd src-485; make clean; cd ..)
	(cd src-tls; make clean; cd ..)
	(cd src-ui; make clean; cd ..)
	rm -f release-osdp-conformance.tgz
	rm -rf opt

build:	all
	mkdir -p opt/osdp-conformance/run/CP
	mkdir -p opt/osdp-conformance/run/MON
	mkdir -p opt/osdp-conformance/run/PD
	mkdir -p opt/osdp-conformance/tmp
	chmod 777 opt/osdp-conformance/tmp
	(cd src-lib; make build; cd ..)
	(cd src-485; make build; cd ..)
	(cd src-ui; make build; cd ..)
	cp doc/config-samples/open-osdp-params-CP.json \
	  opt/osdp-conformance/run/CP/
	cp doc/config-samples/open-osdp-params-MON.json \
	  opt/osdp-conformance/run/MON/
	cp doc/config-samples/open-osdp-params-PD.json \
	  opt/osdp-conformance/run/PD/
	(cd test; make build-test; cd ..)

release:	build
	tar czvf release-osdp-conformance.tgz opt/*

