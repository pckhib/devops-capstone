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

    // stage('Create Kubernetes Cluster') {
    //   steps {
    //     withAWS(region: 'eu-central-1', credentials: 'aws') {
    //       sh 'eksctl create cluster -f cluster.yml'
    //       sh 'aws eks --region eu-central-1 update-kubeconfig --name devops-capstone'
    //     }
    //   }
    // }

    stage('Create Kubernetes configuration') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
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

    stage('Create Blue Deployment') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl apply -f blue-deployment.yml'
        }
      }
    }

    stage('Create Green Deployment') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl apply -f green-deployment.yml'
        }
      }
    }

    stage('Use Blue Deployment') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl apply -f blue-service.yml'
        }
      }
    }

    stage('Wait user approve') {
      steps {
          input "Redirect traffic to green deployment?"
      }
    }

    stage('Use Green Deployment') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl apply -f green-service.yml'
        }
      }
    }

    stage('Deployment Details') {
      steps {
        withAWS(region: 'eu-central-1', credentials: 'aws') {
          sh 'kubectl get pods'
          sh 'kubectl get services'
        }
      }
    }
  }
}