pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="211125359833"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO_NAME="nodeprojectecr"
        IMAGE_TAG="v1"
        REPOSITORY_URI = "public.ecr.aws/v0y1e7x9/nodeprojectecr"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh """aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"""
                }
                 
            }
        }
        
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/HemavathiSundar/NodeProject.git']]])     
            }
        }
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
   stage('Pushing to ECR') {
    steps {
        script {
            // Tag the local Docker image with the ECR repository URI
            sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
            
            // Push the tagged image to ECR
            sh "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
        }
    }
}
}
}
