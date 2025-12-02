ZIP:=b-redstone.zip
MCMETA:=pack.mcmeta
ASSETS:=assets pack.png
MINECRAFT_PATH:=~/.minecraft

.PHONY: $(ZIP) install-zip install-link clean

MCMETA_TEMPLATE = $(MCMETA)_template
VERSIONS_PACK_FORMATS = \
  1.15-1.16.1=5 \
  1.16.2-1.16.5=6 \
  1.17-1.17.1=7 \
  1.18-1.18.2=8 \
  1.19-1.19.2=9 \
  1.19.3=12 \
  1.19.4=13 \
  1.20-1.20.1=15 \
  1.20.2=18 \
  1.20.3-1.20.4=22 \
  1.20.5-1.20.6=32 \
  1.21-1.21.1=34 \
  1.21.2-1.21.3=42 \
  1.21.4=46 \
  1.21.5=55 \
  1.21.6=63 \
  1.21.7-1.21.8=64

VERSIONS = $(foreach pair,$(VERSIONS_PACK_FORMATS),$(word 1,$(subst =, ,$(pair))))

ZIP_TARGETS = $(addprefix b-redstone_,$(addsuffix .zip,$(VERSIONS)))
zip: $(ZIP_TARGETS) b-redstone_1.21.9-1.21.10.zip

# Create the pack.mcmeta file for each version
# using the template and the corresponding pack format.
$(foreach vp,$(VERSIONS_PACK_FORMATS), \
  $(eval ver=$(word 1,$(subst =, ,$(vp)))) \
  $(eval pf=$(word 2,$(subst =, ,$(vp)))) \
  $(eval $(MCMETA)_$(ver): $(MCMETA_TEMPLATE) ; PACK_FORMAT=$(pf) envsubst > $$@ < $$<) \
)

b-redstone_%.zip: $(MCMETA)_% $(ASSETS)
	zip -r $@ $(MCMETA)_$(*) $(ASSETS)
	printf "@ $(MCMETA)_$(*)\n@=$(MCMETA)\n" | zipnote -w $@

install-zip: b-redstone_1.16.2-1.16.5.zip
	cp b-redstone_1.16.2-1.16.5.zip $(MINECRAFT_PATH)/resourcepacks

install-link:
	rm -f $(MINECRAFT_PATH)/resourcepacks/b-redstone
	ln -s $(shell pwd) $(MINECRAFT_PATH)/resourcepacks/b-redstone

vanilla:
	mkdir -p vanilla
	unzip $(MINECRAFT_PATH)/versions/1.16.5/1.16.5.jar -d vanilla

clean:
	rm -f $(ZIP_TARGETS)
	rm -rf vanilla
	rm -rf pack.mcmeta_1*
