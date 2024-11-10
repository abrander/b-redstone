ZIP:=b-redstone.zip
MCMETA:=pack.mcmeta
ASSETS:=assets

.PHONY: lint vanilla $(ZIP) install

$(ZIP): $(MCMETA) $(ASSETS)
	zip -r $@ $^

lint: $(MCMETA)
	jsonlint-php -q $(MCMETA)

install: $(ZIP)
	cp $(ZIP) ~/.minecraft/resourcepacks

vanilla:
	mkdir -p vanilla
	unzip ~/.minecraft/versions/1.16.5/1.16.5.jar -d vanilla

clean:
	rm -rf $(ZIP)

link:
	rm -f ~/.minecraft/resourcepacks/b-redstone-dev
	ln -s $(shell pwd) ~/.minecraft/resourcepacks/b-redstone-dev
