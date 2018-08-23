NAME = busybox

include $(RISCV_ROOTFS_HOME)/Makefile.app

REPO_PATH = repo
$(REPO_PATH):
	mkdir -p $@
	git clone -b 1_29_stable git://git.busybox.net/busybox $@
	cp config $@/.config

$(APP): | $(REPO_PATH)
	$(MAKE) -C $(REPO_PATH)
	ln -sf $(abspath $(REPO_PATH)/busybox) $@
