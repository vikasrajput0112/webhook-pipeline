
pipeline {
    agent any

    environment {
        GITHUB_TOKEN = credentials('github-jenkins')
    }

    
        stage('Setup Webhook') {
    steps {
        sh '''
            apt-get update && apt-get install -y jq || true
            bash ./scripts/setup-webhook.sh
        '''
    }
}


        
        stage('Build') {
            steps {
                echo 'Build successful.'
            }
        }
    }
}

