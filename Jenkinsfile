pipeline {
    agent any
    environment {
        SONAR_PROJECT_KEY = "parnwebapp"
        SONAR_ORG_KEY = "parnwebapp"
        SONAR_HOST = "https://sonarcloud.io"
        SONAR_TOKEN = "5d35078ed1007474ce65ea12ae55b6b68d9eaf4a"
    }
    tools {
        maven 'maven_3.5.2'
    }
    stages {
        stage('CompileandRunSonarAnalysis') {
            steps {
                sh "mvn clean verify sonar:sonar -Dsonar.projectKey=$SONAR_PROJECT_KEY -Dsonar.organization=$SONAR_ORG_KEY -Dsonar.host.url=$SONAR_HOST -Dsonar.login=$SONAR_TOKEN"
            }
        }
    }
}
