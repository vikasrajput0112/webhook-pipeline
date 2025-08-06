
pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh 'bash ./scripts/setup-webhook.sh'
            }
        }

        stage('Build') {
            steps {
                echo 'Build successful.'
            }
        }
    }
}

