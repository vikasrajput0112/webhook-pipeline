pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins') // 🔐 secret text credential in Jenkins
    }

 
        stage('Setup Webhook') {
    steps {
        sh 'sh ./scripts/setup-webhook.sh'
            }
        }



        
        stage('Build') {
            steps {
                echo 'Running build...'
                sh 'docker build -t test-image .'
            }
        }
    }

