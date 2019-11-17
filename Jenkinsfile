pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                mkdir build
                cd build
                sh 'cmake ..'
                sh 'make'
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