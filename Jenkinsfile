node {

    //Define newApp object
    def newApp
    // Get latest tag from branch
    def tag = sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()

    // Log in to private registry
    stage('Login to Registry') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexusAdmin',
                      usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
          sh 'docker login 192.168.51.6:8443 -u $USERNAME -p $PASSWORD'
    }

    stage('Clone repo') {
      checkout scm
    }

    stage('Build image') {
      newApp = docker.build "192.168.51.6:8443/myapp:build"
    }

    stage('Test') {
          docker.image("192.168.51.6:8443/myapp:build").withRun('-p 5000:5000') {c ->
          input message: "Does http://127.0.0.1:5100 look good?"
          }
    }

    stage('Push image') {
          def newtag = sh(returnStdout: true, script: "semver bump patch ${tag}")
          println newtag
          newApp.push "${newtag}"
    }

  }
}
