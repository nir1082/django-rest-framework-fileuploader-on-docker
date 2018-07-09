FROM centos:7

MAINTAINER Anonymous

WORKDIR /root

RUN yum -y update && yum -y install \
         install git \
         gcc \
         make \
         openssl-devel \
         bzip2-devel \
         readline-devel \
         sqlite-devel \
    && yum clean all

# Install pyenv
RUN git clone git://github.com/yyuu/pyenv.git ~/.pyenv

# Set Environments
ENV PATH $PATH:/root/.pyenv/bin:/root/.pyenv/shims

# Install Python3
RUN pyenv install 3.6.5 && pyenv local 3.6.5

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py

# Install Django Rest Framework
RUN pip3 install Django \
         djangorestframework \
         markdown \
         django-filter

# Add Project
RUN mkdir djangoworkspace djangoworkspace/fileuploader
ADD ./fileuploader ./djangoworkspace/fileuploader/

# Run App
EXPOSE 80
CMD python3 djangoworkspace/fileuploader/manage.py runserver `hostname -i`:80
