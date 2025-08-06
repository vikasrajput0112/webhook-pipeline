pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

   stage('Setup Webhook') {
    steps {
        sh '''
            apk add --no-cache dos2unix || true
            dos2unix ./scripts/setup-webhook.sh
            bash ./scripts/setup-webhook.sh
        '''
                        }
            }

     

        stage('Build') {
            steps {
                echo 'Running build...'
                sh 'docker build -t webhook-test-image .'
            }
        }
    }

