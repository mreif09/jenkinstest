pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                mkdir build
                cd build
                sh 'ls'
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