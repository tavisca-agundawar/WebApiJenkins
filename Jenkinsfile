pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                sh 'echo Build'
                sh 'dotnet build WebAPI.sln -p:Configuration=Release -v:q'
            
            }
        }

        stage('Test') {
            steps {
                sh 'echo Test'
                sh 'dotnet test XUnitTestProject1/XUnitTestProject1.csproj -p:Configiration=Release -v:q'
            }
        }

        stage('Publish') {
            steps {
                sh 'echo Publish'
                sh 'dotnet publish WebAPI.sln -p:Configuration=Release -v:q -o Publish'
            }
        }

        stage('Zip') {
            steps {
                sh 'echo Zipping Artifact'
                sh 'zip -r Artifact.zip WebAPI/Publish/'
            }
        }

        

    }
    post { 
        success {
                    sh 'echo ArchiveArtifact'
                    archiveArtifacts artifacts: 'Artifact.zip'
        }
        always{
            echo 'Finished!'
        }
    }
}