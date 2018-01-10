pipeline {
    agent { docker 'ruby' }
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