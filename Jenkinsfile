pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                mkdir build
                cd build
                cmake ..
                make
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