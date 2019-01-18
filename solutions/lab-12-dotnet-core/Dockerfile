FROM openshift/jenkins-slave-base-centos7:v3.10

# Labels consumed by Red Hat build service
LABEL com.redhat.component="rh-dotnet21-jenkins-slave-docker" \
      name="dotnet/dotnet-21-jenkins-slave-centos7" \
      version="2.1" \
      architecture="x86_64" \
      release="1" \
      io.k8s.display-name="Jenkins Slave .NET Core 2.1" \
      io.k8s.description="The jenkins slave dotnet image has the dotnet tools on top of the jenkins slave base image." \
      io.openshift.tags="openshift,jenkins,slave,dotnet,dotnet21"

# Don't download/extract docs for nuget packages
# Don't do initially populate of package cache
# Enable nodejs and dotnet scl
ENV DOTNET_CORE_VERSION=2.1 \
    BASH_ENV=/usr/local/bin/scl_enable \
    ENV=/usr/local/bin/scl_enable \
    PROMPT_COMMAND=". /usr/local/bin/scl_enable" \
    ENABLED_COLLECTIONS="rh-nodejs8 rh-dotnet21" \
    NUGET_XMLDOC_MODE=skip \
    DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1 \
    SONAR_SCANNER_MSBUILD_VERSION=4.3.1.1372 \
    SONAR_SCANNER_VERSION=3.2.0.1227 \
    SONAR_SCANNER_MSBUILD_HOME=/opt/sonar-scanner-msbuild \
    PATH="$SONAR_SCANNER_MSBUILD_HOME:$SONAR_SCANNER_MSBUILD_HOME/sonar-scanner-$SONAR_SCANNER_VERSION/bin:${PATH}"

COPY contrib/bin/scl_enable /usr/local/bin/scl_enable

# Install
RUN INSTALL_PKGS="java-1.8.0-openjdk-devel.x86_64" && \
    x86_EXTRA_RPMS=$(if [ "$(uname -m)" == "x86_64" ]; then echo -n java-1.8.0-openjdk-devel.i686 ; fi) && \
    yum install -y centos-release-scl-rh && \
    yum install -y --enablerepo=centosplus $INSTALL_PKGS $x86_EXTRA_RPMS && \
    rpm -V java-1.8.0-openjdk-devel.x86_64 $x86_EXTRA_RPMS

RUN yum install -y centos-release-dotnet centos-release-scl-rh && \
    INSTALL_PKGS="rh-dotnet21 rh-nodejs8-npm" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
# yum cache files may still exist (and quite large in size)
    rm -rf /var/cache/yum/*    

# Installing mono
# https://www.mono-project.com/download/stable/#download-lin-centos
RUN rpm --import "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF" && \
    curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo && \
    yum install -y mono-complete

# Installing Sonarqube plugin
RUN wget https://github.com/SonarSource/sonar-scanner-msbuild/releases/download/$SONAR_SCANNER_MSBUILD_VERSION/sonar-scanner-msbuild-$SONAR_SCANNER_MSBUILD_VERSION-net46.zip -O /opt/sonar-scanner-msbuild.zip && \
    mkdir -p $SONAR_SCANNER_MSBUILD_HOME && \
    unzip /opt/sonar-scanner-msbuild.zip -d $SONAR_SCANNER_MSBUILD_HOME && \
    rm /opt/sonar-scanner-msbuild.zip && \
    chmod 775 $SONAR_SCANNER_MSBUILD_HOME/*.exe && \
    chmod 775 $SONAR_SCANNER_MSBUILD_HOME/**/bin/* && \
    chmod 775 $SONAR_SCANNER_MSBUILD_HOME/**/lib/*.jar

# Fix permissions...
RUN id && chown -R 1001:0 $HOME && \
    chmod -R g+rw $HOME

USER 1001
RUN id


