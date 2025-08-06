pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins') // 🔐 secret text credential in Jenkins
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh 'chmod +x ./scripts/setup_webhook.sh && ./scripts/setup_webhook.sh'
            }
        }

        stage('Build') {
            steps {
                echo 'Running build...'
                sh 'docker build -t test-image .'
            }
        }
    }
}
