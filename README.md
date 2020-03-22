## ansible-get-docker

This is an ansible role that installs and configure Docker on CentOS7, CentOS8 and Fedora 30.  
By default, it will install:
* latest version of docker-ce (On CentOS8 it will install docker-ce-18.09.9-3)
* docker-compose through pip3
* python3 when the platform is CentOS7 and CentOS8
* docker and selinux module through pip3

**Note:** For CentOS8, it will run something like `firewall-cmd --zone=public --add-masquerade --permanent` to [fix broken DNS in container](https://serverfault.com/questions/987686/no-network-connectivity-to-from-docker-ce-container-on-centos-8).

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

Uncomment the "docker_upstream_repo_*" variable in defaults/main.yml and enter a version number, or provide this variable in other ways to overwrite default value.  
(like -e option in ansible-playbook or "vars:" in your playbook)

### Add users to docker group
Uncomment the "docker_users" variable and in defaults/main.yml and enter users,
or provide this variable in other ways to overwrite default value.

### Template daemon.json file

Firstly, set the "docker_set_daemon_file" variable to true in defaults/main.yml,
or change this variable in other ways to overwrite default value.  
Secondly, edit the templates/etc/docker/daemon.json.j2 file to what you want.  

### Use (self-signed) credentials for docker registry

Firstly, set the "docker_use_certificates" and docker_set_login_credentials variables to true in defaults/main.yml, or change this variable in other ways to overwrite default value.  
Secondly, put your certificates under templates/etc/docker/certs.d/  
Thirdly, edit the "docker_registry" variable in defaults/main.yml.  

### Login to a docker registry
Firstly, set the docker_set_login_credentials variables to true in defaults/main.yml,
or change this variable in other ways to overwrite default value.  
Secondly, edit the "docker_registry" variable in defaults/main.yml.
