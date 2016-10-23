stage 'Package'

node {
    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexusAdmin',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
        // available as an env variable, but will be masked if you try to print it out any which way
        sh 'docker login 192.168.51.6:8443 -u $USERNAME -p $PASSWORD'
    // docker.image("my-environment:v${VERSION_TAG}").push("127.0.0.1:8443/my-environment:v${VERSION_TAG}")
  }
  git 'https://github.com/ed201971/simple_flask.git' // checks out Dockerfile
  def newApp = docker.build "192.168.51.6:8443/myapp:${env.BUILD_TAG}"
  newApp.push "latest" // Replace with "${env.BUILD_TAG}"
}

// stage 'Build'
// node {
// 	git 'https://github.com/ed201971/simple_flask.git' // checks out Dockerfile
//   def newApp = docker.build "127.0.0.1:8443/myapp:${env.BUILD_TAG}"
// 	// docker.build "my-environment:v${VERSION_TAG}"
//   // myEnv.inside {
//   //   sh 'make test'
//   // }
  
// }

stage 'Test'
node {
        docker.image("127.0.0.1:8443/myapp:${env.BUILD_TAG}").withRun('-p 5000:5000') {c ->
        input message: "Does http://127.0.0.1:5000 look good?"
        }
 }

stage 'Deploy'
node {
        sh "docker service update --image 127.0.0.1:8443/myapp:${env.BUILD_TAG} myservice"
 }

  
  