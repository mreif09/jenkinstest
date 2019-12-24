pipeline {
    agent none
    stages {
        stage('Parallel') {
            parallel {
                stage('Docker') {
                    agent {
                        docker {
                            image 'gcc:latest'
                            label 'arm64'
                        }
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
                    agent {
                        docker {
                            image 'gcc:latest'
                            label 'amd64'
                        }
                    }
                    stages {
                        stage('Build AWS') {
                            steps {
                                echo 'Building..'
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