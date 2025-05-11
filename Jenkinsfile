pipeline {
  agent any

  environment {
    GITHUB = credentials('git-creds')
    DOCKERHUB = credentials('docker-creds')
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/daviddvf/proyectoCRUD.git' ,
            credentialsId: 'git-creds', branch: 'main'
      }
    }

    stage('Build & Push Images') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker-creds') {
            def app = docker.build("david/proyectocrud:web", "./backend")
            app.push("latest")
            app.push("${env.BUILD_NUMBER}")
          }
        }
      }
    }

    stage('Deploy with Compose') {
      steps {
        sh '''
          docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW
          cd $WORKSPACE
          docker compose pull
          docker compose down
          docker compose up -d --build
        '''
      }
    }
  }

  post {
    success { echo "¡Build y despliegue completados!" }
    failure { echo "Hubo un fallo en el pipeline." }
  }
}