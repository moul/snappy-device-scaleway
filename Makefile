SNAPVERSION = 0.1

snap/scaleway-c1_$(SNAPVERSION)_all.snap:
	docker run -it --rm --privileged -v $(PWD)/snap:/snap -w /snap moul/snappy-builder snappy build
