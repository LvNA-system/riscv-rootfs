REPO_PATH = repo
NAME = stream
SRCS = $(REPO_PATH)/stream.c
CFLAGS += -DSTREAM_ARRAY_SIZE=1000000 -DNTIMES=5 -DSTREAM_TYPE=int

include $(RISCV_ROOTFS_HOME)/Makefile.compile

$(REPO_PATH):
	mkdir -p $@
	git clone --depth 1 https://github.com/jeffhammond/STREAM $@

$(SRCS): | $(REPO_PATH)
