pipeline {
    
    agent any

    parameters {
        string (name : 'SolutionName', defaultValue: 'WebAPI.sln',description: 'Solution Name')
        string (name : 'TestProjectName', defaultValue: 'XUnitTestProject1/XUnitTestProject1.csproj',description: 'Test project file')
        string (name : 'LocalImage', defaultValue: 'aspnetapp',description: 'Local docker image name')
        string (name : 'RemoteImage', defaultValue: 'webapi',description: 'Remote docker image name')
        string (name : 'Username', defaultValue: 'agundawar',description: 'Username for docker')
        string (name : 'ContainerName', defaultValue: 'webapicontainer',description: 'Docker container name')
    }
    
    stages {
        stage('Build') {
            steps {
                powershell 'dotnet build ${SolutionName} -p:Configuration=release -v:q'
            }
        }

        stage('Test') {
            steps {
                powershell 'dotnet test ${TestProjectName} -p:Configiration=release -v:q'
            }
        }

        stage('Sonarqube analysis'){
            steps {
                powershell 'dotnet ${env:SONAR_MS_TOOL} begin /k:"${env:SolutionName}" /d:sonar.host.url="${env:SONAR_URL}" /d:sonar.login="${env:SONAR_TOKEN}"'
                powershell 'dotnet build'
                powershell 'dotnet ${env:SONAR_MS_TOOL} end /d:sonar.login="${env:SONAR_TOKEN}"'
            }
        }

         stage('Publish') {
            steps {
                powershell 'dotnet publish ${SolutionName} -p:Configuration=release -v:q -o Publish'
            }
        }
        
        stage ('BuildDockerImage')
        {
            steps {
                powershell 'docker build -t ${env:LocalImage} -f Dockerfile .'
            }
        }
        
        stage('Tag and Push image to Docker')
        {
            steps{
                  script{
                    docker.withRegistry('','docker_credentials')
                    {
                        
                        powershell 'docker tag ${env:LocalImage}:latest ${env:Username}/${env:RemoteImage}:latest'
                        powershell 'docker push ${env:Username}/${env:RemoteImage}:latest'
                    }
                }
            }
        }
        
        stage('Remove local docker image')
        {
            steps{
                    powershell 'docker rmi ${env:LocalImage}'
            }
        }
         stage('Pull docker image')
        {
            steps{
                    powershell 'docker pull ${env:Username}/${env:RemoteImage}:latest'
            }
        }
         stage('Run docker image')
        {
            steps{
                    powershell 'docker run -p 9999:9999 --name ${env:ContainerName} ${env:Username}/${env:RemoteImage}'
            }
        }
    }
    post
    { 
        always
        { 
            powershell 'docker stop ${env:ContainerName}'
            powershell 'docker rm ${env:ContainerName}'
            cleanWs()
        }
    }
}