FROM nclans/centos6:latest

RUN yum install -y rpm-build rpmdevtools readline-devel ncurses-devel gdbm-devel tcl-devel openssl-devel db4-devel byacc libyaml-devel libffi-devel make glibc-devel gcc
RUN rpmdev-setuptree

RUN mkdir -p /root/rpmbuild/SOURCES /opt/rpmbuild/SPECS
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.7.tar.gz -O /root/rpmbuild/SOURCES/ruby-2.1.7.tar.gz
RUN wget https://raw.githubusercontent.com/genx7up/ruby.rpm/master/ruby21.spec -O /root/rpmbuild/SPECS/ruby21.spec

RUN rpmbuild -bb /root/rpmbuild/SPECS/ruby21.spec

RUN ls -al /root/rpmbuild/RPMS/`uname -m`

# Define default run command.
CMD ["bash","-c","cp -R /root/rpmbuild/RPMS/* /out"]
