pipeline {
      agent any
      tools {
            maven 'maven_3.9.4'
      }
      stages {
            stage('CompileandRunSonarAnalysis') {
                  steps {
                        sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=parnwebapp -Dsonar.organization=parnwebapp -Dsonar.host.url=https://sonarcloud.io -Dsonar.login=5d35078ed1007474ce65ea12ae55b6b68d9eaf4a'
                  }
            }
      }
}
