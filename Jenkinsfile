pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-webhook')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh '''
                    echo "✅ jq found at: $(command -v jq)"
                    echo "📦 jq version: $(jq --version)"
                    bash ./scripts/setup-webhook.sh
                '''
            }
        }

        stage('Build') {
            steps {
                echo '✅ Build stage executed successfully.'
            }
        }
    }
}
