pipeline {
    agent {
        docker {
            image 'jenkins-agent-with-jq:latest' // Change to your built/pushed image if needed
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
                        echo "❌ ERROR: jq is not installed in this Jenkins agent."
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
