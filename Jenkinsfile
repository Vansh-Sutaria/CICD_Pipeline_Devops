// pipeline {
//     agent any

//     stages {
//         stage('Initialize & Checkout') {
//             steps {
//                 echo 'Starting Pipeline, fetching code...'
//                 checkout scm 
//                 // Removed the failing 'bat attrib +x' command. 
//                 // We rely on 'bat call' in later stages.
//             }
//         }
        
//         stage('Build') {
//             steps {
//                 echo '--- Starting Build Stage: Executing build.bat ---'
//                 // Executing the Windows Batch file
//                 bat 'call build.bat' 
//             }
//             post {
//                 success {
//                     // FIX: Archiving the correct file: build/app-output.txt
//                     archiveArtifacts artifacts: 'build/app-output.txt', fingerprint: true
//                     echo "Build artifact archived successfully."
//                 }
//             }
//         }

//         stage('Test') {
//             steps {
//                 echo '--- Starting Test Stage: Executing test.bat ---'
//                 // Executing the Windows Batch file
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
//                 // FIX: Use 'bat' instead of 'sh' for Windows
//                 bat 'echo "Simulating deployment with archived artifact..."'
//                 echo 'Deployment complete.'
//             }
//         }
//     }
    
//     post {
//         always {
//             cleanWs() 
//         }
//         success {
//             echo '✅ Pipeline finished: SUCCESS!'
//         }
//         failure {
//             echo '❌ Pipeline finished: FAILED. Check logs.'
//         }
//     }
// }

node {
    // 1. Initialization and Checkout
    stage('Initialize & Checkout') {
        echo 'Starting Pipeline, fetching code...'
        // The workspace is automatically created by 'node'
        
        // Checkout the code
        checkout scm
    }

    // 2. Build Stage
    stage('Build') {
        echo '--- Starting Build Stage: Executing build.bat ---'
        
        // Execute the Windows Batch file
        try {
            bat 'call build.bat'
            
            // Post-success action: Archive artifacts
            archiveArtifacts artifacts: 'build/app-output.txt', fingerprint: true
            echo "Build artifact archived successfully."
        } catch (error) {
            // Handle build failure if necessary
            currentBuild.result = 'FAILURE'
            throw error
        }
    }

    // 3. Test Stage
    stage('Test') {
        echo '--- Starting Test Stage: Executing test.bat ---'
        
        // Execute the Windows Batch file
        try {
            bat 'call test.bat'
        } catch (error) {
            currentBuild.result = 'FAILURE'
            throw error
        }
    }

    // 4. Deploy Stage (Scripted 'when' logic)
    stage('Deploy') {
        def shouldDeploy = (currentBuild.result == null || currentBuild.result == 'SUCCESS') && env.BRANCH_NAME == 'main'
        
        if (shouldDeploy) {
            echo '--- Starting Deploy Stage ---'
            // Execute the Windows Batch command
            bat 'echo "Simulating deployment with archived artifact..."'
            echo 'Deployment complete.'
        } else {
            echo 'Deploy stage skipped due to conditional logic (not successful or not on main branch).'
        }
    }

    // 5. Post Actions (Cleanup and Status Reporting)
    stage('Post Actions') {
        try {
            cleanWs() 
            if (currentBuild.result == 'SUCCESS' || currentBuild.result == null) {
                echo '✅ Pipeline finished: SUCCESS!'
            } else {
                echo '❌ Pipeline finished: FAILED. Check logs.'
            }
        } catch (Exception e) {
            // Ensure cleanup runs even if status reporting fails
        }
    }
}