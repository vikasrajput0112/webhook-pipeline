pipeline {
    agent any

    environment {
        REPO_NAME = "your-repo-name"
        IMAGE_NAME = "ghcr.io/your-org-name/${REPO_NAME}:${env.BUILD_NUMBER}"
    }

    triggers {
        githubPush() // 👈 This auto-triggers the pipeline via webhook on push
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push Docker Image (Optional)') {
            when {
                expression { return false } // disable by default
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'ghcr-token', usernameVariable: 'USERNAME', passwordVariable: 'TOKEN')]) {
                    script {
                        sh "echo $TOKEN | docker login ghcr.io -u $USERNAME --password-stdin"
                        sh "docker push ${IMAGE_NAME}"
                    }
                }
            }
        }
    }
}
