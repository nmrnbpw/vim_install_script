#!/bin/bash

CENTOS_VER=$(cat /etc/redhat-release | sed -e 's/CentOS Linux release \([0-9]+\?\)\..*/\1/g')


ZSH_AUTOSUGGESTIONS_VER=0.5.0
ZSH_AUTOSUGGESTIONS_CENTOS8_BUILD=3.1
ZSH_AUTOSUGGESTIONS_CENTOS7_BUILD=1.5
ZSH_AUTOSUGGESTIONS_BUILD=$ZSH_AUTOSUGGESTIONS_CENTOS7_BUILD
if [ $CENTOS_VER -eq 8 ]; then
  ZSH_AUTOSUGGESTIONS_BUILD=$ZSH_AUTOSUGGESTIONS_CENTOS8_BUILD
fi
ZSH_AUTOSUGGESTIONS_RPM_NAME="zsh-autosuggestions-${ZSH_AUTOSUGGESTIONS_VER}-${ZSH_AUTOSUGGESTIONS_BUILD}.x86_64.rpm"
ZSH_AUTOSUGGESTIONS_RPM_URL="https://download.opensuse.org/repositories/shells:/zsh-users:/zsh-autosuggestions/CentOS_${CENTOS_VER}/x86_64/${ZSH_AUTOSUGGESTIONS_RPM_NAME}"
ZSH_AUTOSUGGESTIONS_REPO_URL="https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/CentOS_${CENTOS_VER}/shells:zsh-users:zsh-autosuggestions.repo"


ZSH_COMPLETIONS_VER=0.31.0
ZSH_COMPLETIONS_CENTOS8_BUILD=2.1
ZSH_COMPLETIONS_CENTOS7_BUILD=1.1
ZSH_COMPLETIONS_BUILD=$ZSH_COMPLETIONS_CENTOS7_BUILD
if [ $CENTOS_VER -eq 8 ]; then
  ZSH_COMPLETIONS_BUILD=$ZSH_COMPLETIONS_CENTOS8_BUILD
fi
ZSH_COMPLETIONS_RPM_NAME="zsh-completions-${ZSH_COMPLETIONS_VER}-${ZSH_COMPLETIONS_BUILD}.x86_64.rpm"
ZSH_COMPLETIONS_RPM_URL="https://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/CentOS_${CENTOS_VER}/x86_64/${ZSH_COMPLETIONS_RPM_NAME}"
ZSH_COMPLETIONS_REPO_URL="https://download.opensuse.org/repositories/shells:zsh-users:zsh-completions/CentOS_${CENTOS_VER}/shells:zsh-users:zsh-completions.repo"


ZSH_SYNTAX_HILIGHTING_VER=0.6.0
ZSH_SYNTAX_HILIGHTING_CENTOS8_BUILD=4.1
ZSH_SYNTAX_HILIGHTING_CENTOS7_BUILD=3.7
ZSH_SYNTAX_HILIGHTING_BUILD=$ZSH_SYNTAX_HILIGHTING_CENTOS7_BUILD
if [ $CENTOS_VER -eq 8 ]; then
  ZSH_SYNTAX_HILIGHTING_BUILD=$ZSH_SYNTAX_HILIGHTING_CENTOS8_BUILD
fi
ZSH_SYNTAX_HILIGHTING_RPM_NAME="zsh-syntax-highlighting-${ZSH_SYNTAX_HILIGHTING_VER}-${ZSH_SYNTAX_HILIGHTING_BUILD}.x86_64.rpm"
ZSH_SYNTAX_HILIGHTING_RPM_URL="https://download.opensuse.org/repositories/shells:/zsh-users:/zsh-syntax-highlighting/CentOS_${CENTOS_VER}/x86_64/${ZSH_SYNTAX_HILIGHTING_RPM_NAME}"
ZSH_SYNTAX_HILIGHTING_REPO_URL="https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/CentOS_${CENTOS_VER}/shells:zsh-users:zsh-syntax-highlighting.repo"





curl -L git.io/antigen > antigen.zsh
git clone https://github.com/zsh-users/zsh.git

sudo yum install autoconf -y
pushd zsh
./Util/preconfig
./configure --prefix=$HOME/usr
make -j5 && make install
popd

exit 0


REPOSITORY_MODE=0
if [ $(whoami) == "root" ]; then
  REPOSITORY_MODE=1
fi


if [ $REPOSITORY_MODE -eq 1 ]; then
  # register repository and install by yum
  pushd /etc/yum.repos.d/

  curl -LO ${ZSH_AUTOSUGGESTIONS_REPO_URL}
  yum install zsh-autosuggestions -y

  curl -LO ${ZSH_COMPLETIONS_REPO_URL}
  yum install zsh-completions -y

  curl -LO ${ZSH_SYNTAX_HILIGHTING_REPO_URL}
  yum install zsh-syntax-hilighting -y

  popd
  exit 0
fi

# download rpm file and install by yum
pushd /tmp/

curl -LO ${ZSH_AUTOSUGGESTIONS_RPM_URL}
echo "installing rpm file ..."
sudo yum localinstall ${ZSH_AUTOSUGGESTIONS_RPM_NAME} -y

curl -LO ${ZSH_COMPLETIONS_RPM_URL}
sudo yum localinstall ${ZSH_COMPLETIONS_RPM_NAME} -y

curl -LO ${ZSH_SYNTAX_HILIGHTING_RPM_URL}
sudo yum localinstall ${ZSH_SYNTAX_HILIGHTING_RPM_NAME} -y

popd


git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc





exit 0

