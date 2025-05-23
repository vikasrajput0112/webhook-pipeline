pipeline {
    agent any

    environment {
        REMOTE_IP = '192.168.136.141'
        SSH_USER = 'ubuntu'
        SSH_PASS = 'ubuntu'
    }

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
                    sudo apt-get update -y
                    sudo apt-get install -y git wget
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

                    sh """
                        # Remove existing container named 'vikas' if it exists
                        if [ \$(docker ps -a -q -f name=^/vikas\$) ]; then
                            echo "Removing existing container named 'vikas'"
                            docker rm -f vikas
                        fi

                        # Run new container detached
                        docker run --name vikas -d ${imageName} tail -f /dev/null

                        sleep 5

                        # List containers to debug if needed
                        docker ps -a

                        # Execute git version inside container
                        docker exec vikas git --version
                    """
                }
            }
        }

        stage('Check Git Version on Remote Server') {
            steps {
                script {
                    // Install sshpass if missing
                    sh '''
                        if ! command -v sshpass &> /dev/null; then
                            echo "Installing sshpass..."
                            sudo apt-get update && sudo apt-get install -y sshpass
                        fi
                    '''

                    // SSH to remote server and run sudo git --version
                    sh "sshpass -p '${SSH_PASS}' ssh -o StrictHostKeyChecking=no ${SSH_USER}@${REMOTE_IP} \"echo '${SSH_PASS}' | sudo -S git --version\""
                }
            }
        }
    }
}
