pipeline {
    agent {
        docker {
            image "dachuck/dev-base:0.4.0"
            label "amd64"
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh('''
                    mkdir -p build
                    cd build
                    cmake ..
                    make clean
                    make jenkinstest
                ''')
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh('''
                    cd build
                    make
                    ctest -T Test -j$(nproc)
                    cd ..

                    gcovr ./build -r ./src -b -j$(nproc) --xml-pretty > gcovr.xml

                    cppcheck --force --enable=warning,style,performance,portability -j$(nproc) --xml src/ 2> cppcheck.xml
                    ccodecheck --root=src/ --recursive src/ctes 2>&1 | cpplint_to_cppcheckxml 2> ccodecheck.xml
                ''')
            }
            post {
                always {
                    junit testResults: 'Test.xml', healthScaleFactor: 10.0

                    cobertura coberturaReportFile: 'gcovr.xml', autoUpdateHealth: false, autoUpdateStability: false, conditionalCoverageTargets: '100, 90, 80', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '100, 95, 90', maxNumberOfBuilds: 5, onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false

                    recordIssues tools: [gcc(), cppCheck(pattern: 'cppcheck.xml'), cppCheck(id: 'ccodecheck', name: 'CCodeCheck', pattern: 'ccodecheck.xml')], healthy: 1, unhealthy: 10
                }
            }
        }
    }
}