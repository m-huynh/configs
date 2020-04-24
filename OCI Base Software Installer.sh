#!/bin/bash
echo "
Hello! Welcome to the OCI Software Installation Wizard
Please ensure you are connected to the Oracle VPN
This script pertains to the following software:
1. Homebrew
2. YubiKey Software
3. Bash Add-ons
4. iTerm2
5. PyCharm
6. IntelliJ IDEA
7. Maven
8. BitBucket access
9. OCI PKI Certificates"
read -p "Would you like to install all software packages list previously? [Y/N] " response12
if [[ "$response12" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	chsh -s /bin/bash
  echo "export http_proxy=http://www-proxy-adcq7-new.us.oracle.com:80
  export https_proxy=http://www-proxy-adcq7-new.us.oracle.com:80
  export no_proxy='localhost,127.0.0.1,.oracle.com,.oraclecorp.com,.grungy.us'">>~/.bash_profile
  source ~/.bash_profile
  cd $HOME
	env GIT_SSL_NO_VERIFY=true ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew install opensc
	brew install ykman
	brew install bash-completion
	brew install bash-git-prompt
	echo '[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
   	if [ -f $(brew --prefix)/etc/bash_completion ]; then
   	source $(brew --prefix)/etc/bash_completion
   	fi

   	if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  	 __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  	source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
   	fi'>>~/.bash_profile
	source ~/.bash_profile
	brew cask install iterm2
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
	brew cask install pycharm
	brew cask install intellij-idea
	brew install maven
	brew info maven
	echo 'export M3_HOME="/usr/local/Cellar/maven/3.6.3_1"
	export M3=$M3_HOME/bin
	export PATH=$M3:$PATH'>>~/.bash_profile
	source ~/.bash_profile
	cd $HOME
	mkdir .m2
	cd .m2
	touch settings.xml
echo '<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <profiles>
    <profile>
      <id>release</id>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>libs-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>plugins-release</name>
          <url>https://artifactory.oci.oraclecorp.com/plugins-release</url>
        </pluginRepository>
      </pluginRepositories>
    </profile>
    <profile>
      <id>snapshot</id>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>libs-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </repository>
        <repository>
          <snapshots/>
          <id>snapshots</id>
          <name>libs-snapshot</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-snapshot</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>plugins-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots/>
          <id>snapshots</id>
          <name>plugins-snapshot</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-snapshot</url>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>snapshot</activeProfile>
  </activeProfiles>
</settings>'>>~/.m2/settings.xml
touch mavenrc
echo 'JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'>>mavenrc
sudo mv mavenrc /etc
cd $HOME/.ssh
	echo "What is your Oracle email?"
	read email
	ssh-keygen -t rsa -b 4096 -C "<$email>" -f id_rsa -N ""
	pbcopy < id_rsa.pub
	echo "1. Login with GUID without _US and SSO Password."
	echo "2. Then Click on the Account icon in the upper right."
	echo "3. Choose (Manage Account) from the drop down list."
	echo "4. On the next page choose (SSH Keys) from the choices on the left."
	echo "5. Click (Add Key). Your SSH Key has already been copied."
	echo "6. Just right click in blank box and paste the SSH key and save."
        echo "***To recopy your SSH Key just run command: pbcopy < ~/.ssh/id_rsa.pub"
	open -a firefox -g https://bitbucket.oci.oraclecorp.com
	read -p "Once you have pasted you SSH key to Bitbucket type Y to continue: " response13
fi
if [[ "$response13" =~ ^([yY])$ ]]
then
	cd $HOME
	echo "What is your name?"
	read name
	mkdir workspace
	cd workspace
	git config --global user.name "$name"
	git config --global user.email "$email"
	git clone ssh://git@bitbucket.oci.oraclecorp.com:7999/secinf/sparta-pki.git
	cd sparta-pki
	sudo bash install-roots-osx.sh
	cd scripts
	chmod +x osx_nss_import.sh
	cd ..
	bash scripts/osx_nss_import.sh
  echo "Utilize following link for License keys for IntelliJ and Pycharm:http://slcibhf.us.oracle.com:1111/"
  echo "If you have any further questions refer to file Configurations_V4.0_Students.txt which came with the OCI New Hire Briefing"
exit
fi
if [[ "$response12" =~ ^([nN][oO]|[nN])$ ]]
then
  chsh -s /bin/bash
  echo "export http_proxy=http://www-proxy-adcq7-new.us.oracle.com:80
  export https_proxy=http://www-proxy-adcq7-new.us.oracle.com:80
  export no_proxy='localhost,127.0.0.1,.oracle.com,.oraclecorp.com,.grungy.us'">>~/.bash_profile
  source ~/.bash_profile
  cd $HOME
#Homebrew Install
read -p "Would you like to install Homebrew? [Y/N] " response1
#YUBIKEY Install
read -p "Would you like to install YubiKey Software? [Y/N] " response2
#Bash Add-ons
read -p "Would you like to install Bash Add-ons? [Y/N] " response3
#iTerm2 Install
read -p "Would you like to install iTerm2? [Y/N] " response4
#JDK Install
read -p "Would you like to install JDK? [Y/N] " response5
#PyCharm Install
read -p "Would you like to install PyCharm? [Y/N] " response6
#IntelliJ IDEA Install
read -p "Would you like to install IntelliJ IDEA? [Y/N] " response7
#Maven Install
read -p "Would you like to install Maven? [Y/N] " response8
#SSH keys for BitBucket
read -p "Would you like to setup BitBucket access? [Y/N] " response9
#Install OCI PKI Certificates
read -p "Would you like to install OCI PKI Certificates? [Y/N] " response10
fi
if [[ "$response1" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	env GIT_SSL_NO_VERIFY=true ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi
if [[ "$response2" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	brew install opensc
	brew install ykman
fi
if [[ "$response3" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	cd $HOME
	brew install bash-completion
	brew install bash-git-prompt
	echo '[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
   	if [ -f $(brew --prefix)/etc/bash_completion ]; then
   	source $(brew --prefix)/etc/bash_completion
   	fi

   	if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  	 __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  	source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
   	fi'>>~/.bash_profile
	source ~/.bash_profile 
fi
if [[ "$response4" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	brew cask install iterm2 
fi
if [[ "$response5" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	brew tap AdoptOpenJDK/openjdk
	brew cask install adoptopenjdk8
fi
if [[ "$response6" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	brew cask install pycharm
fi
if [[ "$response7" =~ ^([yY][eE][sS]|[yY])$ ]]
then 
	brew cask install intellij-idea
fi
if [[ "$response8" =~ ^([yY][eE][sS]|[yY])$ ]]
then 
	brew install maven
	brew info maven
	echo 'export M3_HOME="/usr/local/Cellar/maven/3.6.3_1"
	export M3=$M3_HOME/bin
	export PATH=$M3:$PATH'>>~/.bash_profile
	source ~/.bash_profile 
	cd $HOME
	mkdir .m2  
	cd .m2
	touch settings.xml 
echo '<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <profiles>
    <profile>
      <id>release</id>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>libs-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>plugins-release</name>
          <url>https://artifactory.oci.oraclecorp.com/plugins-release</url>
        </pluginRepository>
      </pluginRepositories>
    </profile>
    <profile>
      <id>snapshot</id>
      <repositories>
        <repository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>libs-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </repository>
        <repository>
          <snapshots/>
          <id>snapshots</id>
          <name>libs-snapshot</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-snapshot</url>
        </repository>
      </repositories>
      <pluginRepositories>
        <pluginRepository>
          <snapshots>
            <enabled>false</enabled>
          </snapshots>
          <id>central</id>
          <name>plugins-release</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-release</url>
        </pluginRepository>
        <pluginRepository>
          <snapshots/>
          <id>snapshots</id>
          <name>plugins-snapshot</name>
          <url>https://artifactory.oci.oraclecorp.com/libs-snapshot</url>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
  <activeProfiles>
    <activeProfile>snapshot</activeProfile>
  </activeProfiles>
</settings>'>>~/.m2/settings.xml
touch mavenrc
echo 'JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'>>mavenrc 
sudo mv mavenrc /etc
fi
if [[ "$response9" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	cd $HOME/.ssh
	echo "What is your Oracle email?"
	read email
	ssh-keygen -t rsa -b 4096 -C "<$email>" -f id_rsa -N ""
	pbcopy < id_rsa.pub
	echo "1. Login with GUID without _US and SSO Password." 
	echo "2. Then Click on the Account icon in the upper right."
	echo "3. Choose (Manage Account) from the drop down list." 
	echo "4. On the next page choose (SSH Keys) from the choices on the left."
	echo "5. Click (Add Key). Your SSH Key has already been copied." 
	echo "6. Just right click in blank box and paste the SSH key and save."
        echo "***To recopy your SSH Key just run command: pbcopy < ~/.ssh/id_rsa.pub"
	open -a firefox -g https://bitbucket.oci.oraclecorp.com
	read -p "Once you have pasted you SSH key to Bitbucket type Y to continue: " response11
fi
if [[ "$response11" =~ ^([yY])$ ]]
then
	cd $HOME
	echo "What is your name?"
	read name	
	mkdir workspace
	cd workspace
	git config --global user.name "$name"
	git config --global user.email "$email" 
fi
if [[ "$response10" =~ ^([yY][eE][sS]|[yY])$ ]]
then
	git clone ssh://git@bitbucket.oci.oraclecorp.com:7999/secinf/sparta-pki.git
	cd sparta-pki
	sudo bash install-roots-osx.sh
	cd scripts
	chmod +x osx_nss_import.sh
	cd ..
	bash scripts/osx_nss_import.sh
fi
echo "Utilize following link for License keys for IntelliJ and Pycharm:http://slcibhf.us.oracle.com:1111/"
echo "If you have any further questions refer to file Configurations_V4.0_Students.txt which came with the OCI New Hire Briefing"
exit
