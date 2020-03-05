## ansible-get-docker

This is an ansible role that installs and configure Docker on CentOS7 and Fedora 30.
By default, it will install the latest version of docker-ce, python3 when the platform is CentOS7 and install docker-compose through pip3

## Example
```yml
---

# get-docker.yml
- hosts: example
  become: true
  tasks:
    - import_role:
        name: herealways.get-docker
```

Run: ansible-playbook get-docker.yml

## How-to
### Install a specific version of Docker

Uncomment the "docker_upstream_repo_*" variable in defaults/main.yml and enter a version number.

### Add users to docker group
Uncomment the "docker_users" variable and in defaults/main.yml and enter users.

### Template daemon.json file

Firstly, set the "docker_set_daemon_file" variable to true in defaults/main.yml.
Secondly, edit the templates/etc/docker/daemon.json.j2 file to what you want.

### Use (self-signed) credentials for docker registry

Firstly, set the "docker_use_certificates" and docker_set_login_credentials variables to true in defaults/main.yml.
Secondly, put your certificates under templates/etc/docker/certs.d/
Thirdly, edit the "docker_registry" variable in defaults/main.yml.

### Login to a docker registry
Firstly, set the docker_set_login_credentials variables to true in defaults/main.yml.
Secondly, edit the "docker_registry" variable in defaults/main.yml.
