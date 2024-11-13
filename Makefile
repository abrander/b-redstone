ZIP:=b-redstone.zip
MCMETA:=pack.mcmeta
ASSETS:=assets
MINECRAFT_PATH:=~/.minecraft

.PHONY: $(ZIP) install-zip install-link clean

$(ZIP): $(MCMETA) $(ASSETS)
	zip -r $@ $^

install-zip: $(ZIP)
	cp $(ZIP) $(MINECRAFT_PATH)/resourcepacks

install-link:
	rm -f $(MINECRAFT_PATH)/resourcepacks/b-redstone-dev
	ln -s $(shell pwd) $(MINECRAFT_PATH)/resourcepacks/b-redstone-dev

vanilla:
	mkdir -p vanilla
	unzip $(MINECRAFT_PATH)/versions/1.16.5/1.16.5.jar -d vanilla

clean:
	rm -f $(ZIP)
	rm -rf vanilla
