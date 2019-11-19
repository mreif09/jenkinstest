pipeline {
    agent {
        docker { image 'gcc_gtest:latest' }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh('''
                    mkdir -p build
                    ls
                    cd build
                    ls
                    pwd
                    cmake ..
                    make
                   ''')
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}