pipeline {
    agent any

    stages {
        stage('Test playbook') {
            when {
                branch 'dev'
            }
            steps {
                sh '''
                ansible-playbook -i tests/inventory -b -u vagrant --private-key /var/jenkins_home/ansible/ansible_key tests/test.yml
                '''
            }
        }
    }
}