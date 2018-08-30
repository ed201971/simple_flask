pipeline {
  agent any
  
    stages {
        stage('Build') {
            echo 'Building..'
            def tag = sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()
            println tag
        }
      
        stage('Prep') {
            steps {
                def tag = sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()
                println tag
            }
        }

    stage('Package') {
      steps {
          withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexusAdmin',
                          usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
              // available as an env variable, but will be masked if you try to print it out any which way
              sh 'docker login 192.168.51.6:8443 -u $USERNAME -p $PASSWORD'
          // docker.image("my-environment:v${VERSION_TAG}").push("127.0.0.1:8443/my-environment:v${VERSION_TAG}")
          def tag = sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()
          println tag

          git 'https://github.com/ed201971/simple_flask.git' // checks out Dockerfile
          def newApp = docker.build "192.168.51.6:8443/myapp:${tag}"
          newApp.push "${tag}"
        }
      }
    }

    stage('Test') {
      steps {
          docker.image("192.168.51.6:8443/myapp:${tag}").withRun('-p 5000:5000') {c ->
          input message: "Does http://127.0.0.1:5100 look good?"
          }
       }
    }

  }
}
