practiceSinglePipe {
    agent { docker 'ruby:2.4.3-slim-jessie' }
    stages {
        stage('build') {
            steps {

                sh 'cucumber'
            }
        }
    }
}