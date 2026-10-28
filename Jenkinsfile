pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  serviceAccountName: jenkins-agent
  containers:
    - name: k8s
      image: alpine/k8s:1.37.1
      command: ["sleep"]
      args: ["infinity"]
'''
        }
    }

    stages {
        stage('Deploy UAT') {
            steps {
                container('k8s') {
                    sh 'sh deploy.sh uat'
                }
            }
        }

        stage('Deploy PREPROD') {
            steps {
                container('k8s') {
                    sh 'sh deploy.sh preprod'
                }
            }
        }

        stage('Approve PROD') {
            steps {
                input message: 'Deploy to prod?'
            }
        }

        stage('Deploy PROD') {
            steps {
                container('k8s') {
                    sh 'sh deploy.sh prod'
                }
            }
        }
    }
}
