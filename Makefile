VERSION=1.7.1-rc2

build: boot2docker-vagrant.iso
	time (packer build -parallel=false template.json)

prepare: clean boot2docker-vagrant.iso

boot2docker-vagrant.iso:
	wget -O boot2docker.iso https://github.com/tianon/boot2docker/releases/download/v${VERSION}/boot2docker.iso

clean:
	rm -rf *.iso *.box

.PHONY: clean prepare build
