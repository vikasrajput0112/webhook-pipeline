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
                    // Assuming Dockerfile is in the root of the repo
                    def imageName = 'image-webhook-pipeline'
                    def dockerBuildCommand = "docker build -t ${imageName} ."
                    
                    // Build the Docker image
                    echo "Building Docker image: ${imageName}"
                    sh dockerBuildCommand
                }
            }
        }
    }
}
