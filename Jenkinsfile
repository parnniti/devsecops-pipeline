def app_image

pipeline {
  agent any
  environment {
    SONAR_PROJECT_KEY = 'parnwebapp'
    SONAR_ORG_KEY = 'parnwebapp'
    SONAR_HOST = 'https://sonarcloud.io'

    DOCKER_REGISTRY = 'https://570943728123.dkr.ecr.ap-southeast-1.amazonaws.com'
    AWS_CREDENTIALS = 'aws-credentials'

    KUBECONFIG = 'k3s-config'
    APP_NAMESPACE = 'devsecops'
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
          docker.withRegistry(DOCKER_REGISTRY, "ecr:ap-southeast-1:$AWS_CREDENTIALS") {
            app_image.push("latest")    
          }
        }
      }
    }

    stage('Kubernetes Deployment of ASG Bugg Web Application') {
      steps {
        sh 'chmod +x ./scripts/*'
        withCredentials([[
          $class: 'AmazonWebServicesCredentialsBinding',
          credentialsId: AWS_CREDENTIALS,
          accessKeyVariable: 'AWS_ACCESS_KEY_ID',
          secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
        ]]) {
          withKubeConfig([credentialsId: KUBECONFIG]) {
            sh """
              kubectl -n $APP_NAMESPACE create secret docker-registry aws-ecr \
              --docker-server=$DOCKER_REGISTRY \
              --docker-username=AWS \
              --docker-password=\$(aws ecr get-login-password --region ap-southeast-1) || true
            """
            sh "./scripts/deploy.sh $DOCKER_REGISTRY/${app_image.imageName()}"
          }
        }
      }
    }
  }
}
