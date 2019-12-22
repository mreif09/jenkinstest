pipeline {
    agent {
        docker { image 'gcc:latest' }
    }
    stages {
        stage('Parallel') {
            parallel {
                stage('Docker') {
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