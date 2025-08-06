pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh '''
                    if ! command -v jq &> /dev/null; then
                        echo "❌ jq not installed. Please install jq or switch to a Docker agent with it preinstalled."
                        exit 1
                    fi
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
