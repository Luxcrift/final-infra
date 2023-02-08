pipeline {
    agent any
        // parameters {
        //     booleanParam(name: 'terraformApply', defaultValue: true, description: 'Terraform Apply')
        //     booleanParam(name: 'terraformDestroy', defaultValue: false, description: 'Select Terraform Desntroy')
        //  }
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        AWS_SESSION_TOKEN = credentials('aws_session_token')
        AWS_REGION = "us-east-1"
    }
    stages {
        stage('Terraform Init') {
            agent{
                docker {
                    image 'hashicorp/terraform:light'
                    args '-i --entrypoint='
                }
            }
            steps {
                sh 'cd terraform; terraform init'
            }
        }
        stage('Docker Getenv') {
            steps {
                sh 'source ./automation/docker_getenv.sh'
                sh 'printenv'
            }
        }
        stage('Terraform Validate') {
            agent{
                docker {
                    image 'hashicorp/terraform:light'
                    args '-i --entrypoint='
                }
            }
            steps {
                sh 'cd terraform; terraform validate'
            }
        }
        stage('Terraform Plan') {
            agent{
                docker {
                    image 'hashicorp/terraform:light'
                    args '-i --entrypoint='
                }
            }
            steps {
                sh 'cd terraform; terraform plan -var-file tfvars/$BRANCH_NAME.tfvars -out plan.out'
            }
        }
        stage('Terraform Apply') {
            agent{
                docker {
                    image 'hashicorp/terraform:light'
                    args '-i --entrypoint='
                }
            }
            steps { 
                      sh 'cd terraform; terraform apply "plan.out"'
                    }
                
        }
    //     stage('Terraform Destroy') {
    //         agent{
    //             docker {
    //                 image 'hashicorp/terraform:light'
    //                 args '-i --entrypoint='
    //             }
    //         }
    //         steps {
    //             script {
    //                 if (params.terraformDestroy) {
    //                   sh """
    //                   #!/bin/bash
    //                   cd terraform; terraform destroy -auto-approve -var-file tfvars/dev.tfvars
    //                   """     
    //             }
    //         }
    //     }
    // }

    } // end stages

    // CLEAN WORKSPACES
    post { 
        always { 
            cleanWs()
        }
    }
} // end pipeline
