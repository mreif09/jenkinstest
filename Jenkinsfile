pipeline {
    agent none
    stages {
        stage('Matrix') {
            matrix {
                axes {
                    axis {
                        name 'ARCH'
                        values 'amd64', 'arm64'
                    }
                    axis {
                        name 'CC'
                        values 'gcc'
                    }
                }
                stages {
                    stage('Build') {
                        agent {
                            docker {
                                image '${ARCH}:latest'
                                label 'arm64'
                            }
                        }
                        steps {
                            echo 'Building..'
                            sh('''
                                g++ testfile.cpp -o testfile
                            ''')
                        }
                    }
                    stage('Test') {
                        agent {
                            docker {
                                image '${ARCH}:latest'
                                label 'arm64'
                            }
                        }
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