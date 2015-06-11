SNAPVERSION = 0.1

all: dist/snappy.img

dist/scaleway-c1_$(SNAPVERSION)_all.snap:
	docker run -it --rm --privileged -v $(PWD)/snap:/snap -w /snap moul/snappy-builder snappy build
	@mkdir -p dist
	mv snap/scaleway-c1_$(SNAPVERSION)_all.snap dist/scaleway-c1_$(SNAPVERSION)_all.snap

dist/device.tar.xz:
	@mkdir -p dist
	tar -C device -cjf dist/device.tar.xz .

dist/snappy.img: dist/device.tar.xz dist/scaleway-c1_$(SNAPVERSION)_all.snap
	docker run \
	  -it --rm --privileged \
	  -v $(PWD)/dist:/dist \
	  -w /dist \
	  moul/snappy-builder \
	    ubuntu-device-flash \
	    core 15.04 \
	    --oem scaleway-c1 \
	    --developer-mode \
	    --enable-ssh \
	    --device-part=device.tar.xz \
	    -o snappy.img
