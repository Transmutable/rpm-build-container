#!/bin/sh -x

run() {
  homedir="/home/rpmbuild"
  builddir="${homedir}/build"
  echo "build dir: ${builddir}"
  specfile="${homedir}/${1}"
  echo "specfile: ${specfile}"

  echo "Setting up rpm tree..."
  rpmdev-setuptree

  grep 'BuildRequires: ' "${specfile}" > /dev/null 2>&1 && buildrequires=yes
  if [ "${buildrequires}" ] ; then
    echo "Installing build requirements..."
    sudo yum -y install $(grep 'BuildRequires: ' "${specfile}" | cut -d: -f2-)
  fi

  echo "Installing sources and patches..."
  sudo spectool -A -g -D -C "${builddir}/SOURCES" "${specfile}"

  echo "Linting spec..."
  rpmlint "${specfile}"

  echo "Building..."
  rpmbuild -ba "${specfile}"
}

run "${1}"
