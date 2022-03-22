#!/bin/bash

echo "Adding ContainerOS info to container."
echo "CentOS7_pilot" > /etc/ContainerOS

echo "Apply ugly hack for /etc/hosts rewriting."
# https://github.com/sylabs/singularity/issues/5250
echo >> /etc/hosts

echo "Create folders for mounting host-fs later."
mkdir -p /pool
mkdir -p /usr/libexec/condor/
mkdir -p /cephfs
mkdir -p /cvmfs
mkdir -p /ops/cvmfs
mkdir -p /scratch

echo "Creating job working directory."
mkdir -p /jwd

echo "Create directory for site-specific VO configuration."
mkdir -p etc/site-config/atlas

echo "Dirty hack: Create /etc/fstab."
echo "singularity / rootfs rw 0 0" > /etc/fstab

echo "Update."
yum clean all
yum -y update

echo "Install EPEL."
yum -y install epel-release

echo "Update again..."
yum -y update

echo "Update again, epel-release may have been updated..."
yum -y update

echo "Install WLCG repo..."
yum -y install https://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rpm

echo "Update again..."
yum -y update

echo "Update again, wlcg-repo may have been updated..."
yum -y update

echo "Install EGI UMD-4 repo..."
yum -y install https://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm

echo "Update again..."
yum -y update

echo "Update again, EGI UMD-4 repo may have been updated..."
yum -y update

echo "Setting up locales..."
sed -i 's/^override_install_langs.*//' /etc/yum.conf
yum -y reinstall glibc-common

echo "Install some basics."
yum -y install	vim \
		openssh-server \
		wget

echo "Installing HTCondor repo GPG key..."
wget https://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
rpm --import RPM-GPG-KEY-HTCondor
rm -f RPM-GPG-KEY-HTCondor

echo "Install HTCondor repo..."
yum install -y https://research.cs.wisc.edu/htcondor/repo/8.8/el7/release/htcondor-release-8.8-1.el7.noarch.rpm

echo "Update again..."
yum -y update

echo "Install Python3.6."
yum -y install	python36

echo "Create virtual environment and install condor-git-config."
python3.6 -m venv /opt/env
source /opt/env/bin/activate
python3.6 -m pip install --no-cache-dir condor_git_config
deactivate

echo "Install HTCondor..."
yum -y install condor

# Since /usr/libexec/condor is bind-mounted, it containes the
# HTCondor version installed on the WN which might differ
# the version installed inside the container. To allow for
# this difference, copy the version to be used by the pilot
# inside the container to a separate directory
mkdir -p /usr/libexec/condor_pilot/
cp -ar /usr/libexec/condor/* /usr/libexec/condor_pilot/

#echo "Install Lmod (environment modules tool)."
#yum -y install	Lmod

# See: https://gitlab.cern.ch/linuxsupport/rpms/HEP_OSlibs/blob/el7/README-el7.md
echo "Install ATLAS requirements (HEP_OSlibs)."
yum -y install	HEP_OSlibs

# See: https://its.cern.ch/jira/browse/ADCINFR-132
echo "Install seccomp library (singularity)."
yum -y install	libseccomp

echo "Install Belle 2 requirements (package "wn" from UMD-4 repo)."
yum -y install	wn

echo "Creating /etc/grid-security and symlinking vomsdir and certificates from CVMFS there."
mkdir -p /etc/grid-security
rm -rf /etc/grid-security/certificates
ln -s /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/etc/grid-security-emi/certificates /etc/grid-security/
rm -rf /etc/grid-security/vomsdir
ln -s /cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase/x86_64/emi/current-SL7/etc/grid-security/vomsdir /etc/grid-security/

echo "Install shells."
yum -y install	zsh \
		bash \
		bash-completion

echo "Install some commandline tools."
yum -y install	openssl

echo "Install fuse for xrootd."
yum -y install	fuse-libs

echo "Install some performance monitoring tools."
yum -y install	perf

echo "Install some graphics stuff."
yum -y install	dbus-x11 \
		xauth \
		xclip

echo "Install tools for CephFS quota checking and ACLs."
yum -y install	attr \
		acl

echo "Install Kerberos client tools."
yum -y install	krb5-workstation

echo "Configure mail to relay via localhost."
echo "set smtp=smtp://127.0.0.1" >> /etc/mail.rc

echo "Conserve some space."
yum clean all
rm -rf /var/cache/yum

echo "Set timezone to Europe/Berlin."
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
