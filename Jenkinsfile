pipeline{
    agent any
    tools {
        maven 'maven-3.9.2'
    }
    stages{
        stage('Code_Pull'){
            steps{
                git branch: 'main', url: 'https://github.com/gampasivakumar4422/Task-1'
            }
        }
        stage('Code_Build'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Code_Quality_Analysis'){
            steps{
                sh 'mvn sonar:sonar'
            }
        }
        stage('Image_Build'){
            steps{
                sh 'docker build -t sivakumar4422/tomcat:$BUILD_ID .'
            }
        }
        stage('Image_Push'){
            steps{
            withDockerRegistry(credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/') {
           sh 'docker push sivakumar4422/tomcat:$BUILD_ID'
             }
          }
        }
        stage('Deploy'){
            steps{
                sshagent(['staging_server']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@13.127.36.54 << EOF
                    sudo docker pull sivakumar4422/tomcat:$BUILD_ID
                    sudo docker run -d --name webapp$BUILD_ID -p ${i}:8080 sivakumar4422/tomcat:$BUILD_ID
                    '''
             }
            }
        }
        
    }
}
