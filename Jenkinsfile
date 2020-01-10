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
                    make testfile.o
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
                    make utest
                    ./utest --gtest_output="xml:./utest.xml"
                ''')
            }
        }
    }
}