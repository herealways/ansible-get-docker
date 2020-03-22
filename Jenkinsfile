pipeline {
    agent {
        label 'jenkins-host'
    }
    environment {
        VAGRANT_PROJECT_PATH="/root/vagrant_projects/ansible_get_docker"
    }
    stages {
        stage('Test playbook') {
            when {
                branch 'dev'
            }
            steps {
                sh './Vagrant/vm_setup.sh'
                withCredentials([sshUserPrivateKey(credentialsId: 'ansible_key',\
                keyFileVariable: 'ANSIBLE_KEY')]) {
                    ansiblePlaybook(playbook: 'tests/test.yml',\
                    inventory: 'tests/inventory',\
                    //credentialsId: "${ANSIBLE_KEY}",\
                    hostKeyChecking : false,\
                    colorized: true,\
                    extras: "-u vagrant --private-key ${ANSIBLE_KEY}")
                }
            }
        }
    }
    post {
        always {
            sh './Vagrant/vm_halt.sh'
        }
    }
}