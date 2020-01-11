pipeline {
    agent {
        docker {
            image "dachuck/dev-base:0.0.2"
            label "amd64"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh('''
                    make testfile.o
                ''')
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh('''
                    make utest
                    ./utest --gtest_output="xml:utest.xml"
                ''')
            }
            post {
                always {
                    junit '*.xml'
                }
            }
        }
    }
}