FROM ubuntu:20.04

# Set a non-interactive timezone (prevents tzdata from prompting)
ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Etc/UTC

WORKDIR /app
ADD . /app

# Update and upgrade ubuntu packages, install Python 3.7, MySQL client and other dependencies
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.7 python3-pip python3.7-dev python3-distutils && \
    apt-get install -y mysql-client-8.0 libmysqlclient-dev && \
    apt-get install -y libxml2-dev libxslt-dev libffi-dev libssl-dev build-essential

# Update pip to latest version
# RUN python3.7 -m pip install --upgrade pip

# Copy and install requirements
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Django management commands
# RUN python3 manage.py makemigrations
# Uncomment the line below if you want to apply migrations at build time
# RUN python3.7 manage.py migrate

# Collect static files
RUN python3 manage.py collectstatic --noinput

# Expose port and start application
EXPOSE 8000
CMD ["python3.7", "manage.py", "runserver", "0.0.0.0:8000"]
