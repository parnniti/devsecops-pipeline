def app_image

pipeline {
  agent any
  environment {
    SONAR_PROJECT_KEY = 'parnwebapp'
    SONAR_ORG_KEY = 'parnwebapp'
    SONAR_HOST = 'https://sonarcloud.io'

    DOCKER_REGISTRY = 'https://registry.hub.docker.com/v2/'
    DOCKER_CREDENTIALS = 'dockerhub'
  }
  tools {
    maven 'maven_3.5.2'
  }
  stages {
    stage('CompileandRunSonarAnalysis') {
      steps {
        withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
          sh "mvn clean verify sonar:sonar -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.organization=$SONAR_ORG_KEY -Dsonar.host.url=$SONAR_HOST -Dsonar.login=$SONAR_TOKEN"
        }
      }
    }
    stage('RunSCAAnalysisUsingSnyk') {
      steps {
        withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
          sh 'mvn snyk:test -fn'
        }
      }
    }
    stage('Build') {
      steps {
        script {
          app_image = docker.build('asg')
        }
      }
    }
    stage('Push') {
      steps {
        script {
          docker.withRegistry(DOCKER_REGISTRY, DOCKER_CREDENTIALS) {
            app_image.push("latest")
          }
        }
      }
    }
  }
}
