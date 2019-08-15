NAME = strace

include $(RISCV_ROOTFS_HOME)/Makefile.app

REPO_PATH = repo
TARBALL = strace-5.2.tar.xz
CONFIG_FLAGS = CC=riscv64-unknown-linux-gnu-gcc \
			   CXX=riscv64-unknown-linux-gnu-g++ \
			   --host=riscv64 \
			   --enable-mpers=no

$(TARBALL):
	curl -O https://strace.io/files/5.2/$(TARBALL)
	
$(REPO_PATH): $(TARBALL)
	tar xf $(TARBALL)
	rm -rf $@
	mv $(shell basename $(TARBALL) .tar.xz) $@

$(APP): | $(REPO_PATH)
	cd $(REPO_PATH) && ./configure $(CONFIG_FLAGS)
	$(MAKE) -C $(REPO_PATH)
	cd build && ln -sf ../repo/strace strace
