pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/vikasrajput0112/webhook-pipeline.git', branch: 'main'
            }
        }

        stage('Install git and wget') {
            steps {
                sh '''
                    echo Updating package list...
                    apt-get update -y
                    apt-get install -y git wget
                '''
            }
        }

        stage('Verify Installation') {
            steps {
                sh '''
                    echo "Git Version:"
                    git --version

                    echo "Wget Version:"
                    wget --version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = 'image-webhook-pipeline'
                    echo "Building Docker image: ${imageName}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }

        stage('Run Docker Container and Display Git Version') {
            steps {
                script {
                    def imageName = 'image-webhook-pipeline'
                    echo "Running Docker container with name 'vikas'"

                    // Run container detached and keep it alive with tail -f /dev/null
                    sh """
                        docker run --name vikas -d ${imageName} tail -f /dev/null
                        sleep 5
                        docker exec vikas git --version
                    """
                }
            }
        }
    }

    post {
        always {
            // Cleanup step to stop and remove the container after the pipeline completes
            sh '''
                docker rm -f vikas || true
            '''
        }
    }
}
