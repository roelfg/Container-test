FROM centos:centos7
#COPY . /app
ADD bootstrap.sh /
RUN chmod +x bootstrap.sh && /bootstrap.sh
#RUN mkdir -p etc/profile.d/
COPY etc/profile.d/03-condor_environment.sh etc/profile.d/03-condor_environment.sh
#COPY ../../../common/etc/profile.d/03-condor_environment.sh etc/profile.d/03-condor_environment.sh
#RUN chmod +x etc/profile.d/03-condor_environment.sh && /etc/profile.d/03-condor_environment.sh
