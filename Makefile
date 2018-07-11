IMAGES=base base-jre base-service base-jre-service base-builder base-sbt-builder 
PUBLISH_TARGETS=$(IMAGES:%=publish-%)
PUBLISH_AMAZON_TARGETS=$(IMAGES:%=publish-amazon-%)
CLEAN_TARGETS=$(IMAGES:%=clean-%)

.PHONY: all $(IMAGES) publish clean

all: $(IMAGES)

test: all

$(IMAGES):
	@echo -e "\033[92mBuilding $@\033[0m"
	WD=images/$@ make -f images/$@/Makefile

publish: $(IMAGES) $(PUBLISH_TARGETS)

publish-amazon: $(IMAGES) $(PUBLISH_AMAZON_TARGETS)

publish-amazon-%: %
	WD=images/$* make -f images/$*/Makefile publish-amazon

publish-%: %
	WD=images/$* make -f images/$*/Makefile publish

clean: $(CLEAN_TARGETS)
	rm -f rootfs/rootfs.tar.gz

clean-%:
	WD=images/$* make -f images/$*/Makefile clean

rootfs/rootfs.tar.gz:
	./build-rootfs

base: rootfs/rootfs.tar.gz
base-jre base-service base-builder: base
base-jre-service: base-jre
base-sbt-builder: base-builder
