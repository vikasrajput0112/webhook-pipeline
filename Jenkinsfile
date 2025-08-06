pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh '''
                    echo "🔍 Checking if jq is available..."
                    if ! command -v jq &> /dev/null; then
                        echo "❌ ERROR: jq is not installed in this Jenkins agent."
                        echo "➡️  Please install jq in the agent or use a Docker image with jq."
                        exit 1
                    fi

                    echo "🚀 Running webhook setup script..."
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
