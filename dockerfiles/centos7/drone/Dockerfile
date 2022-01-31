FROM centos:centos7
#COPY . /app
ADD bootstrap.sh /
RUN chmod +x bootstrap.sh && /bootstrap.sh
COPY etc/profile.d/03-condor_environment.sh /etc/profile.d/03-condor_environment.sh
