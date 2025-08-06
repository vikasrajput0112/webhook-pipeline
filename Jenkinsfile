pipeline {
    agent {
        docker {
            image 'jenkins-agent-with-jq:latest' // Replace with full image name if pushing to DockerHub
        }
    }

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    stages {
        stage('Setup Webhook') {
            steps {
                sh '''
                    echo "🔍 Checking if jq is available..."
                    if ! command -v jq &> /dev/null; then
                        echo "❌ jq not installed. Exiting."
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
