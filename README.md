# AIDE

This image is a CentOS 7 based container which contains the AIDE (Advanced Intrusion Detection Environment) file and directory integrity checker. It is heavily based on iitg@gmail.com's implementation:
https://github.com/iitggithub/aide


# Supported Versions

AIDE Version | Git branch | Tag name
-------------| ---------- |---------
0.15.1       | master     | latest
0.15.1       | 0.15.1     | 0.15.1

# Getting Started

There's two ways to get up and running, the easy way and the... less... easy way.

## The Easy Way (Standalone)

Fire up AIDE

```
docker run -d --name aide -v /data/apache/aide:/var/lib/aide anotherit7/aide:latest
```

## The Less Easy Way (Docker Compose)

The github repo contains a docker-compose.yml you can use as a base. The docker-compose.yml is compatible with docker-compose 1.5.2+.

```
aide:
  image: anotherit7/aide:latest
  volumes:
    - /data/apache/aide:/var/lib/aide
```

By running 'docker-compose up -d' from within the same directory as your docker-compose.yml, you'll be able to bring the container up.

# Volumes

## AIDE Integrity Database /var/lib/aide

/var/lib/aide contains the AIDE integrity database file aide.db.tar.gz. If this file does not exist when the container starts, it will be created automatically. It is strongly recommended that this file be backed up to a secure location. This database is your baseline from which all filesystem changes are compared against so keep a copy somewhere safe.

If aide_init.sh finds a file called aide.conf in this directory, AIDE will use this instead of its default configuration file.

After initilization (/var/lib/aide/aide.db.gz has been created), subsequent executions of the container will run against the database, detect, log any file changes and update the db to reflect the current filesystem. A new container will be created each time the docker run command is executed. To avoid creating a new container each time, use this command:

Replace container_name with the name/id of your running container.

```
# remove the previous container first
docker rm aide

# use this command to re-run aide
docker run -d --name aide --rm -v /data/apache/aide:/var/lib/aide anotherit7/aide:latest
```

# Environment Variables

None.

# The End
