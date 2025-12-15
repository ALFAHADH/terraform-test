pipeline {
    agent any

    environment {
        TF_PLAN_FILE = "terraform.tfplan"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=${TF_PLAN_FILE}'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve ${TF_PLAN_FILE}'
            }
        }
    }
}
