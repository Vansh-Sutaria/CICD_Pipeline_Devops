pipeline {
    agent any

    stages {
        stage('Initialize & Checkout') {
            steps {
                echo 'Starting Pipeline, fetching code...'
                checkout scm 
                // Grant execution permission to the scripts
                bat 'attrib +x build.sh test.sh' 
            }
        }
        
        stage('Build') {
            steps {
                echo '--- Starting Build Stage: Executing build.sh ---'
                bat 'call build.bat' 
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app-output.zip', fingerprint: true
                    echo "Build artifacts archived."
                }
            }
        }

        stage('Test') {
            steps {
                echo '--- Starting Test Stage: Executing test.sh ---'
                bat 'call test.bat' 
            }
        }

        stage('Deploy') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
                branch 'main' 
            }
            steps {
                echo '--- Starting Deploy Stage ---'
                sh 'echo "Simulating deployment with archived artifact..."'
            }
        }
    }
    
    post {
        always {
            cleanWs() 
        }
        success {
            echo '✅ Pipeline finished: SUCCESS'
        }
        failure {
            echo '❌ Pipeline finished: FAILED. Check logs.'
        }
    }
}