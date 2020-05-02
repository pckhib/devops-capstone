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

    stage('Create Kubernetes Cluster') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'eksctl create cluster -f cluster.yml'
          sh 'aws eks --region eu-central-1 update-kubeconfig --name devops-capstone'
        }
      }
    }

    stage('Test Kubernetes configuration') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl get svc'
        }
      }
    }
  }
}