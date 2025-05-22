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
                    echo "Updating package list..."
                    sudo apt-get update -y

                    echo "Installing git..."
                    sudo apt-get install -y git

                    echo "Installing wget..."
                    sudo apt-get install -y wget
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
    }
}
