ifeq ($(ROOTFS_HOME),)
	ROOTFS_HOME = $(abspath .)/../..
endif

ifeq (run, $(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

APP_DIR ?= $(shell pwd)
INC_DIR += $(APP_DIR)/include/
DST_DIR ?= $(APP_DIR)/build/
APP ?= $(APP_DIR)/build/$(NAME)

.DEFAULT_GOAL = $(APP)

$(shell mkdir -p $(DST_DIR))

# Compilation flags

CROSS_COMPILE = riscv64-unknown-linux-gnu-

AS = $(CROSS_COMPILE)gcc
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++
LD = $(CROSS_COMPILE)gcc

INCLUDES  = $(addprefix -I, $(INC_DIR))
ISA_DEF = __ISA_$(shell echo $(ISA) | tr a-z A-Z)__

CFLAGS   += -O2 -MMD $(INCLUDES)
CXXFLAGS += -O2 -MMD $(INCLUDES)

# Files to be compiled
OBJS = $(addprefix $(DST_DIR)/, $(addsuffix .o, $(basename $(SRCS))))

# Compilation patterns
$(DST_DIR)/%.o: %.cpp
	@echo + CXX $<
	@mkdir -p $(dir $@)
	@$(CXX) $(CXXFLAGS) -c -o $@ $<
$(DST_DIR)/%.o: %.c
	@echo + CC $<
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) -c -o $@ $<

$(APP): $(OBJS)
	@echo + LD $@
	@$(LD) $(LDFLAGS) -o $(APP) $(OBJS)

# Dependencies
DEPS = $(addprefix $(DST_DIR)/, $(addsuffix .d, $(basename $(SRCS))))
-include $(DEPS)

.PHONY: install clean

install: $(APP)
	@cp $(APP) $(ROOTFS_HOME)/rootfsimg/build/$(NAME)

clean: 
	rm -rf $(APP_DIR)/build/
