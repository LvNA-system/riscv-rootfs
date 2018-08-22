$(shell mkdir -p rootfsimg/build)

APPS = hello
APPS_DIR = $(addprefix apps/, $(APPS))

.PHONY: rootfsimg $(APPS_DIR) clean

rootfsimg: $(APPS_DIR)

$(APPS_DIR): %:
	-$(MAKE) -C $@ install

clean:
	-$(foreach app, $(APPS_DIR), $(MAKE) -C $(app) clean ;)
	-rm -f rootfsimg/build/*
