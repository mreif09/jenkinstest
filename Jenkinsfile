pipeline {
    agent {
        docker {
            image "dachuck/dev-base:0.0.2"
            label "amd64"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh('''
                    make testfile.o
                ''')
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh('''
                    make utest
                    ./utest --gtest_output="xml:./testfile_test.xml"
                    gcovr -r . -f testfile --xml-pretty > gcovr.xml
                    gcovr -r . --html --html-details -o gcovr-report.html
                ''')
            }
            post {
                always {
                    junit '*_test.xml'
                    cobertura coberturaReportFile: 'gcovr-report.html'
                }
            }
        }
    }
}