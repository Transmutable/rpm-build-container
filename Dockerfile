FROM centos:latest

LABEL version="0.1"
LABEL description="Create rpm packages"

RUN yum -y install make gcc rpmdevtools rpmlint sudo && \
    useradd rpmbuild && \
    /bin/echo "%_topdir /build" > /home/rpmbuild/.rpmmacros
    
USER rpmbuild

ADD run.sh /run.sh

ADD sudoers /etc/sudoers.d/rpmbuild-sudoers

CMD [ "sudo", "-u", "rpmbuild", "/run.sh" ]
