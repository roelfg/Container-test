FROM centos:centos7
#COPY . /app
ADD bootstrap.sh /
RUN chmod +x bootstrap.sh && /bootstrap.sh
COPY etc/resolv.conf /etc/resolv.conf
COPY etc/profile.d/03-condor_environment.sh /etc/profile.d/03-condor_environment.sh
COPY etc/profile.d/05-helpful_env.sh /etc/profile.d/05-helpful_env.sh
COPY etc/profile.d/10-fixup_singularity.sh /etc/profile.d/10-fixup_singularity.sh
COPY etc/profile.d/11-container_fixes.sh /etc/profile.d/11-container_fixes.sh
COPY etc/profile.d/12-resources_and_mt.sh /etc/profile.d/12-resources_and_mt.sh
COPY etc/profile.d/13-prompt_setup.sh /etc/profile.d/13-prompt_setup.sh
COPY etc/profile.d/20-cuda.sh /etc/profile.d/20-cuda.sh
COPY etc/profile.d/21-condor_mpi.sh /etc/profile.d/21-condor_mpi.sh
COPY etc/profile.d/22-condor_fixes.sh /etc/profile.d/22-condor_fixes.sh
COPY etc/profile.d/60-setupATLAS.sh /etc/profile.d/60-setupATLAS.sh
COPY etc/profile.d/60-setupBelle.sh /etc/profile.d/60-setupBelle.sh
COPY etc/profile.d/70-belleEnv.sh /etc/profile.d/70-belleEnv.sh
