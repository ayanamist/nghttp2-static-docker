FROM centos:centos5

ARG MAKE_J=1

ADD build.sh /
RUN touch /var/lib/rpm/* &&\
  yum install -y wget &&\
  wget -T 30 -O /etc/yum.repos.d/slc5-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc5-devtoolset.repo &&\
  rpm --import http://ftp.scientificlinux.org/linux/scientific/5x/x86_64/RPM-GPG-KEYs/RPM-GPG-KEY-cern &&\
  yum install -y devtoolset-2 make binutils automake autoconf libtool pkgconfig &&\
  scl enable devtoolset-2 /build.sh &&\
  yum remove -y devtoolset-2 make binutils automake autoconf libtool pkgconfig wget &&\
  yum clean all
