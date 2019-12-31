pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image "${CC}:latest"
                    label "amd64"
                }
            }
            steps {
                echo 'Building..'
                sh('''
                    g++ testfile.cpp -o testfile
                ''')
            }
        }
        stage('Test') {
            agent {
                docker {
                    image "${CC}:latest"
                    label "amd64"
                }
            }
            steps {
                echo 'Testing..'
                sh('./testfile')
            }
        }
    }
}