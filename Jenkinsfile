pipeline {
  agent any

  stages {

    stage('Init Deploy') {
      steps {

        script {
          DEPLOY_DIR = 'deploydir'
          CODE_DIR = 'helloworld-springboot'
          // DEPLOY_USER = 'ci'
          // DEPLOY_KEY = ''
          "${DEPLOY_KEY}"'
        }

        sh "if [ ! -d deploydir  ]; then mkdir deploydir; fi"
        dir(DEPLOY_DIR) {
          deleteDir()
          git url: 'https://github.com/GoogleCloudPlatform/getting-started-java.git'
        }
      }
    }
    
    stage('mvn Build') {
        steps {
            dir(DEPLOY_DIR) {
                dir(CODE_DIR) {
                    sh "echo 'server.port = 8100' >  src/main/resources/application.properties"
                    sh "mvn package"
                    sh "chmod a+x /var/lib/jenkins/workspace/virtual-environment/deploydir/helloworld-springboot/target/helloworld-springboot-0.0.1-SNAPSHOT.jar"
                }
            }
        }
    }
    
    // stage('mvn Tests') {
    //     steps {
    //         dir(DEPLOY_DIR) {
    //             dir(CODE_DIR) {
    //                 // TODO think about
    //             }
    //         }
    //     }
    // }
    
    // stage('mvn Deploy') {
    //     steps {
    //         dir(DEPLOY_DIR) {
    //             dir(CODE_DIR) {
    //                 // TODO create deploy user
    //                 // TODO add systemd scrip /puppet/files/myapp.service
    //                 sh "systemctl start myapp.service"       
    //             }
    //         }
    //     }
    // }


    // stage('mvn Run') {
    //     steps {
    //         dir(DEPLOY_DIR) {
    //             dir("helloworld-springboot") {
    //                 // think about adding
    //                 // -Dspring.profiles.active=jenkins  
    //                 //         <configuration>    ADD to pom.xml
    //                 // <executable>true</executable>
    //                 // </configuration> 
    //             }
    //         }
    //     }
    // }

  }
}