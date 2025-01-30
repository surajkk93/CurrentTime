pipeline{
    agent any
    environment{
        SONAR_HOME= tool "sonar"
    }
    stages{
        stage("Clone Code from GitHub"){
            steps{
                git url: "https://github.com/surajkk93/CurrentTime.git", branch: "main"
            }
        }
        stage("SonarQube Quality Analysis"){
            steps{
                withSonarQubeEnv("sonar"){
                    sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=currenttime -Dsonar.projectKey=currenttime"
                }
            }
        }
	stage("OWASP Dependency Check") {
    		steps {
       		 script {
           		 dependencyCheck additionalArguments: '--scan ./ --format JSON --out dependency-check-reports', odcInstallation: 'DP-Check'
        		}
        		dependencyCheckPublisher pattern: 'dependency-check-reports/dependency-check-report.json'
   		 }
	}
        stage("Sonar Quality Gate Scan"){
            steps{
                timeout(time: 2, unit: "MINUTES"){
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        stage("Trivy File System Scan"){
            steps{
                sh "trivy fs --format  table -o trivy-fs-report.html ."
            }
        }
        stage("Docker Build"){
            steps{
                sh "docker build -t currenttime ."
            }
        }
        stage ("Trivy Image Scan"){
            steps{
                sh "trivy image --format json --output trivy-image-report.json --severity HIGH,CRITICAL currenttime"
            }
        }
        stage ("Docker run"){
            steps{
                sh "docker run -dp 3000:80 currenttime"
            }
        }
    }
}
