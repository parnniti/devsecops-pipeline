def app_image

pipeline {
  agent any
  environment {
    SONAR_PROJECT_KEY = 'parnwebapp'
    SONAR_ORG_KEY = 'parnwebapp'
    SONAR_HOST = 'https://sonarcloud.io'

    DOCKER_REGISTRY = 'https://570943728123.dkr.ecr.ap-southeast-1.amazonaws.com'
    DOCKER_CREDENTIALS = 'ecr:ap-southeast-1:aws-credentials'

    KUBECONFIG = 'k3s-config'
  }
  tools {
    maven 'maven_3.5.2'
  }
  stages {
    // stage('CompileandRunSonarAnalysis') {
    //   steps {
    //     withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
    //       sh "mvn clean verify sonar:sonar -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.organization=$SONAR_ORG_KEY -Dsonar.host.url=$SONAR_HOST -Dsonar.login=$SONAR_TOKEN"
    //     }
    //   }
    // }

    // stage('RunSCAAnalysisUsingSnyk') {
    //   steps {
    //     withCredentials([string(credentialsId: 'SNYK_TOKEN', variable: 'SNYK_TOKEN')]) {
    //       sh 'mvn snyk:test -fn'
    //     }
    //   }
    // }

    // stage('Build') {
    //   steps {
    //     script {
    //       app_image = docker.build('asg')
    //     }
    //   }
    // }

    stage('Push') {
      steps {
        script {
          docker.withRegistry(DOCKER_REGISTRY, DOCKER_CREDENTIALS) {
            sh 'ls ~/.docker/config.json'
            // app_image.push("latest")
          }
        }
      }
    }

    // stage('Kubernetes Deployment of ASG Bugg Web Application') {
    //   steps {
    //     sh 'chmod +x ./scripts/*'
    //     withKubeConfig([credentialsId: KUBECONFIG]) {
    //       sh "./scripts/deploy.sh $DOCKER_REGISTRY/${app_image.imageName()}"
    //     }
    //   }
    // }
  }
}
