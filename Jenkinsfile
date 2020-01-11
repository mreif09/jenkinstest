pipeline {
    agent {
        docker {
            image "dachuck/dev-base:0.3.0"
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

                    cppcheck --force --enable=warning,style,performance,portability --xml testfile.cpp 2> cppcheck.xml
                    ccodecheck testfile.cpp 2>&1 | ./cpplint_to_cppcheckxml.py 2> ccodecheck.xml
                ''')
            }
            post {
                always {
                    junit testResults: '*_test.xml', healthScaleFactor: 10.0

                    cobertura coberturaReportFile: 'gcovr.xml', autoUpdateHealth: false, autoUpdateStability: false, conditionalCoverageTargets: '100, 90, 80', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '100, 95, 90', maxNumberOfBuilds: 5, onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
                    // publishHTML reportFiles: 'gcovr-report*.html', allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: '', reportName: 'Coverage Report', reportTitles: ''

                    recordIssues tools: [gcc(), cppCheck(pattern: 'cppcheck.xml'), cppCheck(id: 'ccodecheck', name: 'CCodeCheck', pattern: 'ccodecheck.xml')], healthy: 1, unhealthy: 10
                }
            }
        }
    }
}