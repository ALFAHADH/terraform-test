pipeline {
    agent any

    stages {

        stage('Select Action') {
            steps {
                script {
                    ACTION = input(
                        id: 'TerraformAction',
                        message: 'Choose what you want to do with AWS resources:',
                        parameters: [
                            choice(
                                name: 'ACTION',
                                choices: ['APPLY', 'DESTROY'],
                                description: 'Apply = Create resources, Destroy = Delete resources'
                            )
                        ]
                    )
                    echo "You selected: ${ACTION}"
                }
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'aws_creds',
                    usernameVariable: 'AWS_ACCESS_KEY_ID',
                    passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan / Destroy Plan') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'aws_creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )]) {

                        if (ACTION == 'APPLY') {
                            echo "Running Terraform Plan..."
                            sh 'terraform plan -out=tfplan'
                        } else {
                            echo "Running Terraform Destroy Plan..."
                            sh 'terraform plan -destroy -out=tfplan'
                        }
                    }
                }
            }
        }

        stage('Apply or Destroy') {
            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'aws_creds',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
                    )]) {

                        if (ACTION == 'APPLY') {
                            echo "Applying Terraform changes..."
                            sh 'terraform apply -auto-approve tfplan'
                        } else {
                            echo "Destroying Terraform resources..."
                            sh 'terraform apply -auto-approve tfplan'
                        }
                    }
                }
            }
        }
    }
}


