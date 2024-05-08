pipeline {
    agent any
    
    environment {
        // Define JFrog Artifactory URL
        ARTIFACTORY_URL = 'https://hemadevops.jfrog.io/artifactory/api/docker/hemarepokey'
        // Define Docker image tag
        DOCKER_IMAGE_TAG = 'v1'
        // Define JFrog API token
        //JFROG_API_TOKEN = credentials('jfrog-api-token'
        JFROG_API_TOKEN = ${{ secrets.JFROG_API_TOKEN }}
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Dockerfile location
                    def dockerfile = 'Dockerfile'
                    // Docker build command
                    def dockerBuildCommand = "docker build -t ${DOCKER_IMAGE_TAG} -f ${Dockerfile} ."
                    
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
        
        stage('Push Docker Image to JFrog Artifactory') {
            steps {
                script {
                    // Configure JFrog CLI
                    sh 'jfrog rt config --url ${ARTIFACTORY_URL} --apikey ${JFROG_API_TOKEN} --interactive=false'
                    
                    // Tag Docker image
                    def dockerTagCommand = "docker tag ${DOCKER_IMAGE_TAG} ${ARTIFACTORY_URL}/${DOCKER_IMAGE_TAG}"
                    sh script: dockerTagCommand
                    
                    // Push Docker image to Artifactory
                    def dockerPushCommand = "jfrog rt docker-push ${DOCKER_IMAGE_TAG} ${ARTIFACTORY_URL}"
                    sh script: dockerPushCommand
                }
            }
        }
    }
}
