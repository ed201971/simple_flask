node {

    // Get latest tag from branch
    def tag = sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()

    // Log in to private registry
    stage('Log in to Registry') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexusAdmin',
                      usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
          sh 'docker login 192.168.51.6:8443 -u $USERNAME -p $PASSWORD'

      //git 'https://github.com/ed201971/simple_flask.git' // checks out Dockerfile
      // def newApp = docker.build "192.168.51.6:8443/myapp:${tag}"
      // newApp.push "${tag}"
    }

    stage('Clone repo') {
      checkout scm
    }

    stage('Build image') {
      def newApp = docker.build "192.168.51.6:8443/myapp:${tag}"
    }

    stage('Test') {
          docker.image("192.168.51.6:8443/myapp:${tag}").withRun('-p 5000:5000') {c ->
          input message: "Does http://127.0.0.1:5100 look good?"
          }
    }

    stage('Push tags') {
          newApp.push "${tag}"
    }

  }
}
