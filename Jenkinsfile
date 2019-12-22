pipeline {
    agent none
    stages {
        stage('Parallel') {
            parallel {
                stage('Docker') {
                    agent {
                        docker { image 'gcc:latest' }
                    }
                    stages {
                        stage('Build Docker') {
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
                stage('AWS') {
                    stages {
                        stage('checkout') {
                            agent {
                                docker { image 'gcc:latest' }
                            }
                            steps {
                                echo 'checkout and stash..'
                                stash includes: '*.cpp, *.hpp', name: 'files'
                            }
                        }
                        stage('Build') {
                            options { skipDefaultCheckout() }
                            agent {
                                node 'AWS'
                            }
                            steps {
                                echo 'Building..'
                                unstash name: 'files'
                                sh('''
                                    clang++ testfile.cpp -o testfile
                                ''')
                            }
                        }
                    }
                 }
            }
        }
    }
}