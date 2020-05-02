pipeline {
  agent any

  environment {
    imageName = "pckhib/devops-capstone:latest"
  }

  stages {
    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e *.html'
      }
    }

    stage('Build Docker image') {
      steps {
        script {
          buildImage = docker.build("${imageName}")
        }
      }
    }

    stage('Push image to DockerHub') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com/', 'dockerhub') {
            buildImage.push()
          }
        }
      }
    }
  }
}