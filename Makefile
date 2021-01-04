ifndef ARKOS_ROOT
    ARKOS_ROOT := /opt/arkos
endif

BUILD=build-$(shell lsb_release -cs)
UTEST=OFF
CMAKE_ARGS:=$(CMAKE_ARGS)

all:
	@mkdir -p $(BUILD)
	@cd $(BUILD); cmake .. -DBUILDING_TEST=$(UTEST) -DCMAKE_INSTALL_PREFIX=${ARKOS_ROOT} -DCMAKE_BUILD_TYPE=Release $(CMAKE_ARGS) && $(MAKE)
	@echo -e "\n Now do 'make install' to install this package.\n"

unittest:
	@$(MAKE) all UTEST=ON

clean:
	@rm -rf $(BUILD)

install:
	@cd $(BUILD); $(MAKE) install

package:
	@$(MAKE) all
	@cd $(BUILD); $(MAKE) package
