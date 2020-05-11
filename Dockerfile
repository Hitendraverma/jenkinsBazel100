FROM hitendra0665/bazel100poc:jenkinsBazel100

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Name the jobs
ARG JENKINS_HOME="/var/jenkins_home"
ARG job_name_1="Bazel-cpp-build"
ARG job_name_2="Bazel-java-build"

# Create the job workspaces
RUN mkdir -p "$JENKINS_HOME"/workspace
RUN mkdir -p "$JENKINS_HOME"/workspace/${job_name_1}
RUN mkdir -p "$JENKINS_HOME"/workspace/${job_name_2}

# Create the jobs folder recursively
RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}
RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_2}

# Add the custom configs to the container
COPY --chown=jenkins:jenkins ${job_name_1}/config.xml "$JENKINS_HOME"/jobs/${job_name_1}/config.xml
COPY --chown=jenkins:jenkins ${job_name_2}/config.xml "$JENKINS_HOME"/jobs/${job_name_2}/config.xml

# Create build file structure
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/latest/
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_1}/builds/1/

# Create build file structure
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_2}/latest/
#RUN mkdir -p "$JENKINS_HOME"/jobs/${job_name_2}/builds/1/
