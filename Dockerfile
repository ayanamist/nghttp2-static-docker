FROM centos:centos5

ARG MAKE_J=1

ADD build.sh /
RUN touch /var/lib/rpm/* &&\
  echo clean_requirements_on_remove=1 >> /etc/yum.conf &&\
  yum install -y wget &&\
  wget -nv -T 30 -O /etc/yum.repos.d/devtools-2.repo http://people.centos.org/tru/devtools-2/devtools-2.repo &&\
  yum install -y devtoolset-2 make binutils automake autoconf libtool pkgconfig &&\
  scl enable devtoolset-2 /build.sh &&\
  yum remove -y devtoolset-2 make binutils automake autoconf libtool pkgconfig wget &&\
  yum clean all
