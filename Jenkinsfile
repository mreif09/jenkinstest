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
                        stage('Test Docker') {
                            steps {
                                echo 'Testing..'
                                sh('./testfile')
                            }
                        }
                    }
                }
                stage('AWS') {
                    options { skipDefaultCheckout() }
                    agent {
                        node 'AWS'
                    }
                    stages {
                        stage('Checkout for AWS') {
                            agent {
                                node 'local-ssh-slave'
                            }
                            steps {
                                echo 'checkout and stash..'
                                checkout scm
                                stash exclude: '.git', name: 'files'
                            }
                        }
                        stage('Build AWS') {
                            steps {
                                echo 'Building..'
                                unstash name: 'files'
                                sh('''
                                    clang++ testfile.cpp -o testfile
                                ''')
                            }
                        }
                        stage('Test AWS') {
                            steps {
                                echo 'Testing..'
                                sh('./testfile')
                            }
                        }
                    }
                 }
            }
        }
    }
}