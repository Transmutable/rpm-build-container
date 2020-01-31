# RPM build container

This repo is used to create a Docker image that makes it pretty handy to build an RPM package via `rpm` or `yum` commands on RedHat/CentOS/Alpine/etc Linux distributions.

This works for simple rpm spec files but you may want to fork this repo and build your own Docker image with your build tools pre-installed or to use a different structure for the build directories.

This repo is based off of [Robert de Bock](https://github.com/robertdebock/)'s [docker-rpmbuild](https://github.com/robertdebock/docker-rpmbuild). Most of the changes from their work was to simplify the run.sh script a bit and change where the build directory is written.

## Building and using a local Docker image

If you have Docker installed then you can build a local version of this image like so:

	git clone https://github.com/Transmutable/rpm-build-container.git
	cd rpm-build-container
	docker build -t rpm-build:v0 .

Once you have the local image you can go into your repo and build an rpm package like so:

	cd ~/path/to/my/project/repo/
	docker run -v "$(PWD):/home/rpmbuild" rpm-build:v0 /run.sh ./path/to/your/project.spec

If successful, your RPM should be created in `./rpmbuild/RPMS/<arch like x86_64>/`

If you'd like to understand how rpm works then I recommend the [RPM Packaging Guide](https://rpm-packaging-guide.github.io/).

