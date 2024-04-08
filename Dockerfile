FROM ubuntu:20.04
# # FROM 
WORKDIR ./
ADD . ./
# RUN apt-get update
# RUN apt-get -y upgrade
RUN apt-get update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y libmysqlclient-dev \
    pkg-config \
    python \
    libxml2-dev \
    libxslt-dev \
    libffi-dev \
    libssl-dev \
    build-essential

RUN apt-get install -y python3-pip

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# RUN python3 manage.py makemigrations
# RUN python3 manage.py migrate


# RUN python3 manage.py collectstatic --noinput
COPY . .
EXPOSE 8000
# RUN chmod 777 run.sh
CMD ["python3", "run.py"]
