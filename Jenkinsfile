pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'dotnet build WebAPI.sln -p:Configuration=Release -v:q'
            
            }
        }

        stage('test') {
            steps {
                sh 'echo test'
                sh 'dotnet test XUnitTestProject1/XUnitTestProject1.csproj -p:Configiration=Release -v:q'
            }
        }

        stage('Publish') {
            steps {
                sh 'echo test'
                sh 'dotnet publish WebAPI.sln -p:Configuration=Release -v:q -o Publish'
            }
        }

         stage('deploy') {
            steps {
                sh 'dotnet WebAPI/Publish/WebAPI.dll'
            }
        }
    }
    post { 
        always { 
            sh 'deleteDir()'
            sh 'echo deleted workspace'
        }
    }
}