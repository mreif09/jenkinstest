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
                    make clean
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
                    gcovr -b -r . -f testfile --xml-pretty > gcovr.xml
                    gcovr -b -r . -f testfile --html-details -o gcovr-report.html
                ''')
            }
            post {
                always {
                    junit testResults: '*_test.xml', healthScaleFactor: 10.0
                    cobertura coberturaReportFile: 'gcovr.xml', autoUpdateHealth: false, autoUpdateStability: false, conditionalCoverageTargets: '100, 51, 90', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '100, 21, 91', maxNumberOfBuilds: 5, onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
                    publishHTML reportFiles: 'gcovr-report*.html', allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportName: 'Coverage Report', reportTitles: ''
                }
            }
        }
    }
}