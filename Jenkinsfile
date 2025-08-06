pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                // Use `sh` to avoid chmod issues
                 sh 'bash ./scripts/setup-webhook.sh'
            }
        }
     

        stage('Build') {
            steps {
                echo 'Running build...'
                sh 'docker build -t webhook-test-image .'
            }
        }
    }
}
