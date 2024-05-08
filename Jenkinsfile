pipeline {
    agent any
    
    environment {
        // Define Docker image tag
        DOCKER_IMAGE_TAG = 'hema1001/nodeimg:latest'
        // Define DockerHub username and password
        DOCKERHUB_USERNAME = 'hema1001'
        DOCKERHUB_PASSWORD = 'Hemasundar123@'
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Dockerfile location
                    def dockerfile = 'Dockerfile'
                    // Docker build command
                    def dockerBuildCommand = "docker build -t ${DOCKER_IMAGE_TAG} -f ${dockerfile} ."
                    
                    // Execute Docker build command
                    sh script: dockerBuildCommand, returnStatus: true
                    // Check if the Docker build was successful
                    if (currentBuild.result == 'SUCCESS') {
                        echo 'Docker build successful'
                    } else {
                        error 'Docker build failed'
                    }
                }
            }
        }
        
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Docker login to Docker Hub
                    sh "docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}"
                    
                    // Docker push command
                    def dockerPushCommand = "docker push ${DOCKER_IMAGE_TAG}"
                    // Execute Docker push command
                    sh script: dockerPushCommand
                }
            }
        }
    }
}
