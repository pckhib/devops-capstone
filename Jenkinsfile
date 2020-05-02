properties([pipelineTriggers([githubPush()])])

pipeline {
  agent any

  stages {
    stage('Lint HTML') {
      steps {
        sh 'tidy -q -e *.html'
      }
    }
  }
}