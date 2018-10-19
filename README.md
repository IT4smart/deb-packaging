# IT4smart Debian and Ubuntu packaging
This repository gathers the deb packaging files used to build IT4S softwares.

## Building packages
We generate a fresh chroot for every package we want to build.

### Rebuilding package
To rebuild the `management-agent` package for Debian Jessie, change to the corresponding directory:
`# cd deb-packaging/debian-jessie/management-agent` Then run the command:
`# sudo ../../stockanalyses-debbuild.sh i386`  This will download the source tarball in the  sources  file, create the Debian source package and run the pbuilder command that creates the packages.
 The resulting packages are in the  `/tmp/`  directory

### Updating a package
To update the `management-agent` package for Debian Jessie, change to the corresponding directory:
`# cd deb-packaging/debian-jessie/management-agent` Change the  sources  file to the correct source tarball. The first field is the URL to download the tarball and the second field is the name of the source tarball (should match the convention pkgname_pkgversion.orig.tar.gz).
 Example of  sources  file:

`https://github.com/hack3d/stockanalyses-downloader/archive/0.1.0.tar.gz stockanalyes-downloader_0.1.0.orig.tar.gz`


Then create a new changelog entry for the packages:
`# ./changelog.sh > debian/changelos`

You are ready to run the `stockanalyses-debbuild.sh` that will download the source and build the package:
`# sudo ../../stockanalyses-debbuild.sh i386`
