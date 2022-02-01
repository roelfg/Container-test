FROM centos:centos7
#COPY . /app
ADD bootstrap.sh /
RUN chmod +x bootstrap.sh && /bootstrap.sh
COPY etc/resolv.conf /etc/resolv.conf
COPY etc/profile.d/03-condor_environment.sh /etc/profile.d/03-condor_environment.sh
