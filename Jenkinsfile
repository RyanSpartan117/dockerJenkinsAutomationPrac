pipeline {
    agent { docker 'ruby:2.4.3-slim-jessie' }
    stages {
        stage('build') {
            steps {
            	build 'practiceSinglePipe'
                sh 'cucumber'
            }
        }
    }
}


// node {
    
//   stage('testing') {

//   	git 'https://github.com/RyanSpartan117/dockerJenkinsAutomationPrac'
//   }

//   img = docker.build('coxauto/jenkins-docker-ruby-example:latest', '.')

// }