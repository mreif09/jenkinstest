pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image "gcc:latest"
                    label "amd64"
                }
            }
            steps {
                echo 'Building..'
                sh('''
                    g++ testfile.cpp -o testfile.o -c
                ''')
            }
        }
        stage('Test') {
            agent {
                docker {
                    image "dachuck/dev-base:0.0.2"
                    label "amd64"
                }
            }
            steps {
                echo 'Testing..'
                sh('''
                    g++ test.cpp testfile.o -o utest
                    ./utest
                ''')
            }
        }
    }
}