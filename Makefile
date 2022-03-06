VERSION         := 5.17.0
TARGET          := $(shell uname -r)
DKMS_ROOT_PATH  := /usr/src/aquacomputer_d5next-$(VERSION)

KERNEL_MODULES	:= /lib/modules/$(TARGET)

ifneq ("","$(wildcard /usr/src/linux-headers-$(TARGET)/*)")
# Ubuntu
KERNEL_BUILD	:= /usr/src/linux-headers-$(TARGET)
else
ifneq ("","$(wildcard /usr/src/kernels/$(TARGET)/*)")
# Fedora
KERNEL_BUILD	:= /usr/src/kernels/$(TARGET)
else
KERNEL_BUILD	:= $(KERNEL_MODULES)/build
endif
endif

obj-m	:= $(patsubst %,%.o,aquacomputer_d5next)
obj-ko	:= $(patsubst %,%.ko,aquacomputer_d5next)

.PHONY: all modules clean dkms-install dkms-install-swapped dkms-uninstall

all: modules

modules:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) modules

clean:
	@$(MAKE) -C $(KERNEL_BUILD) M=$(CURDIR) clean

dkms-install:
	dkms --version >> /dev/null
	mkdir -p $(DKMS_ROOT_PATH)
	cp $(CURDIR)/dkms.conf $(DKMS_ROOT_PATH)
	cp $(CURDIR)/Makefile $(DKMS_ROOT_PATH)
	cp $(CURDIR)/aquacomputer_d5next.c $(DKMS_ROOT_PATH)

	sed -e "s/@CFLGS@/${MCFLAGS}/" \
	    -e "s/@VERSION@/$(VERSION)/" \
	    -i $(DKMS_ROOT_PATH)/dkms.conf

	dkms add aquacomputer_d5next/$(VERSION)
	dkms build aquacomputer_d5next/$(VERSION)
	dkms install aquacomputer_d5next/$(VERSION)

dkms-uninstall:
	dkms remove aquacomputer_d5next/$(VERSION) --all
	rm -rf $(DKMS_ROOT_PATH)