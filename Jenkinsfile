stage 'Package'

node {
    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexusAdmin',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
        // available as an env variable, but will be masked if you try to print it out any which way
        sh 'docker login 192.168.51.6:8443 -u $USERNAME -p $PASSWORD'
    // docker.image("my-environment:v${VERSION_TAG}").push("127.0.0.1:8443/my-environment:v${VERSION_TAG}")
  }

  sh(returnStdout: true, script: "git tag --sort version:refname | tail -1").trim()

  git 'https://github.com/ed201971/simple_flask.git' // checks out Dockerfile
  def newApp = docker.build "192.168.51.6:8443/myapp:${env.BUILD_TAG}"
  newApp.push "${env.BUILD_TAG}" // Replace with "${env.BUILD_TAG}"
}

stage 'Test'
node {
        sh "echo ${env}"
        docker.image("192.168.51.6:8443/myapp:${env.BUILD_TAG}").withRun('-p 5000:5000') {c ->
        input message: "Does http://127.0.0.1:5100 look good?"
        }
 }

stage 'Deploy'
node {
        sh "docker service update --image 192.168.51.6:8443/myapp:${env.BUILD_TAG} myservice"
 }

  
  
