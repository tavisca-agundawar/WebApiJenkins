pipeline {
    agent any
    stages {

        stage('Build') {
            steps {
                bat 'echo Build'
                bat 'dotnet build WebAPI.sln -p:Configuration=Release -v:q'
            
            }
        }

        stage('Test') {
            steps {
                bat 'echo Test'
                bat 'dotnet test XUnitTestProject1/XUnitTestProject1.csproj -p:Configiration=Release -v:q'
            }
        }

        stage('Publish') {
            steps {
                bat 'echo Publish'
                bat 'dotnet publish WebAPI.sln -p:Configuration=Release -v:q -o Publish'
            }
        }

        stage('Zip') {
            steps {
                bat 'echo Zipping Artifact'
                bat 'zip -r Artifact.zip WebAPI/Publish/'
            }
        }

        

    }
    post { 
        success {
                    bat 'echo ArchiveArtifact'
                    archiveArtifacts artifacts: 'Artifact.zip'
        }
        always{
            echo 'Finished!'
        }
    }
}