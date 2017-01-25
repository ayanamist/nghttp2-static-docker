FROM centos:centos5

ARG MAKE_J

ADD build.sh /
RUN touch /var/lib/rpm/* &&\
  echo clean_requirements_on_remove=1 >> /etc/yum.conf &&\
  yum install -y wget &&\
  wget -nv -T 30 -O /etc/yum.repos.d/devtools-2.repo http://people.centos.org/tru/devtools-2/devtools-2.repo &&\
  yum install -y devtoolset-2 make binutils automake autoconf libtool pkgconfig file | tee /yum.log &&\
  scl enable devtoolset-2 /build.sh &&\
  grep -P '^\s*Installing\s*:\s*([a-zA-Z0-9\-\_]+)\s*\d+/\d+\s*$' /yum.log | awk -F ' ' '{print $3}' | xargs -i rpm -e {} --nodeps &&\
  rm -f /yum.log &&\
  rpm -e wget &&\
  yum clean all
