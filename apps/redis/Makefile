NAME = redis-server

include $(RISCV_ROOTFS_HOME)/Makefile.app

REPO_PATH = repo
$(REPO_PATH):
	mkdir -p $@
	git clone --depth 1 -b 4.0.2 https://github.com/antirez/redis.git $@
	cd $@ && git apply ../riscv-cross-compile.patch

$(APP): | $(REPO_PATH)
	CROSS_COMPILE=riscv64-unknown-linux-gnu- $(MAKE) -C $(REPO_PATH)
	ln -sf $(abspath $(REPO_PATH)/src/$(NAME)) $@
	riscv64-unknown-linux-gnu-strip $(abspath $(REPO_PATH)/src/$(NAME))
