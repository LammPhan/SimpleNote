.PHONY : get-modules get all

MODULES := $(wildcard modules/*)

all:
	${MAKE} get-modules
	$(MAKE) get
	

get:
	flutter pub get

get-modules:
	for module in $(MODULES); do \
		cd $${module} ; \
		echo "Updating dependencies on $${module}" ; \
		flutter pub get ; \
		cd ../../ ; \
	done