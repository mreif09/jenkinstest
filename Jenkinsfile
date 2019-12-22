pipeline {
    agent {
        docker { image 'gcc:latest' }
    }

    stages {
        stage('Build') {
            parallel {
                stage('Build Docker') {
                    steps {
                        echo 'Building..'
                        sh('''
                            g++ testfile.cpp -o testfile
                        ''')
                    }
                }
                stage('Build AWS') {
                    options { skipDefaultCheckout() }
                    agent {
                        node 'AWS'
                    }
                    steps {
                        echo 'Building..'
                        sh('''
                            clang++ testfile.cpp -o testfile
                        ''')
                    }
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh('./testfile')
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}