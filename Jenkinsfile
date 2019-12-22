pipeline {
    agent {
        docker { image 'gcc:latest' }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh('''
                    g++ testfile.cpp -o testfile
                   ''')
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh('testfile')
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}