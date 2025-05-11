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

    stage('Build & Push') {
      steps {
        script {
          def imageName = "daviddvf/proyectocrud:web"
      // Construimos desde la carpeta "backend"
        docker.build(imageName, "-f backend/Dockerfile backend")
          // Login + Push
          docker.withRegistry('https://registry.hub.docker.com', 'docker-creds') {
            docker.image(imageName).push('latest')
          }
        }
      }
    }

    stage('Deploy with Compose') {
  steps {
    withCredentials([
      usernamePassword(
        credentialsId: 'docker-creds',
        usernameVariable: 'DOCKERHUB_USR',
        passwordVariable: 'DOCKERHUB_PSW'
      )
    ]) {
      // Nos movemos a la carpeta donde está el docker-compose.yml
      dir('backend') {
        sh '''
          
          docker login -u $DOCKERHUB_USR -p $DOCKERHUB_PSW

          
          docker compose pull

          
          docker compose down

          
          docker compose up -d --build
        '''
      }
    }
  }
}
  }

  post {
    success { echo "¡Build y despliegue completados!" }
    failure { echo "Hubo un fallo en el pipeline." }
  }
}