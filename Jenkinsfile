// pipeline {
//     agent any

//     stages {
//         stage('Initialize & Checkout') {
//             steps {
//                 echo 'Starting Pipeline, fetching code...'
//                 checkout scm 
//                 // Grant execution permission to the scripts
//                 bat 'attrib +x build.sh test.sh' 
//             }
//         }
        
//         stage('Build') {
//             steps {
//                 echo '--- Starting Build Stage: Executing build.sh ---'
//                 bat 'call build.bat' 
//             }
//             post {
//                 success {
//                     archiveArtifacts artifacts: 'build/app-output.zip', fingerprint: true
//                     echo "Build artifacts archived."
//                 }
//             }
//         }

//         stage('Test') {
//             steps {
//                 echo '--- Starting Test Stage: Executing test.sh ---'
//                 bat 'call test.bat' 
//             }
//         }

//         stage('Deploy') {
//             when {
//                 expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
//                 branch 'main' 
//             }
//             steps {
//                 echo '--- Starting Deploy Stage ---'
//                 sh 'echo "Simulating deployment with archived artifact..."'
//             }
//         }
//     }
    
//     post {
//         always {
//             cleanWs() 
//         }
//         success {
//             echo '✅ Pipeline finished: SUCCESS'
//         }
//         failure {
//             echo '❌ Pipeline finished: FAILED. Check logs.'
//         }
//     }
// }

pipeline {
    agent any

    stages {
        stage('Initialize & Checkout') {
            steps {
                echo 'Starting Pipeline, fetching code...'
                checkout scm 
                // Removed the failing 'bat attrib +x' command. 
                // We rely on 'bat call' in later stages.
            }
        }
        
        stage('Build') {
            steps {
                echo '--- Starting Build Stage: Executing build.bat ---'
                // Executing the Windows Batch file
                bat 'call build.bat' 
            }
            post {
                success {
                    // FIX: Archiving the correct file: build/app-output.txt
                    archiveArtifacts artifacts: 'build/app-output.txt', fingerprint: true
                    echo "Build artifact archived successfully."
                }
            }
        }

        stage('Test') {
            steps {
                echo '--- Starting Test Stage: Executing test.bat ---'
                // Executing the Windows Batch file
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
                // FIX: Use 'bat' instead of 'sh' for Windows
                bat 'echo "Simulating deployment with archived artifact..."'
                echo 'Deployment complete.'
            }
        }
    }
    
    post {
        always {
            cleanWs() 
        }
        success {
            echo '✅ Pipeline finished: SUCCESS!'
        }
        failure {
            echo '❌ Pipeline finished: FAILED. Check logs.'
        }
    }
}
