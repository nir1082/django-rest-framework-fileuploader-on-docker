FROM centos:7

MAINTAINER Anonymous

WORKDIR /root

RUN yum -y update
RUN yum -y install git
RUN yum -y install gcc
RUN yum -y install make
RUN yum -y install openssl-devel
RUN yum -y install bzip2-devel
RUN yum -y install readline-devel
RUN yum -y install sqlite-devel

RUN yum clean all

# Install pyenv
RUN git clone git://github.com/yyuu/pyenv.git ~/.pyenv

# Set environments
ENV PATH $PATH:/root/.pyenv/bin
ENV PATH $PATH:/root/.pyenv/shims

# Install Python3
RUN pyenv install 3.6.5
RUN pyenv local 3.6.5

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py

# Install Django Rest Framework
RUN pip3 install Django
RUN pip3 install djangorestframework
RUN pip3 install markdown
RUN pip3 install django-filter

# Add FileUploader Project
RUN mkdir djangoworkspace
RUN mkdir djangoworkspace/fileuploader
ADD ./fileuploader ./djangoworkspace/fileuploader/

# Run App
EXPOSE 80
CMD python3 djangoworkspace/fileuploader/manage.py runserver `hostname -i`:80
