pipeline {
    agent any 
    stages {
        stage('Build') { 
            steps {
                sh 'pip3 install -r requirements.txt' 
            }
        }

        stage('Test') { 
            steps {
                sh 'python3 manage.py test' 
            }
        }

        stage('Deploy to staging') { 
            steps {
                sh 'ssh -o StrictHostKeyChecking=no staging-user@49.50.69.229 "source env/bin/activate; \
                cd ciCdDemo; \
                git pull origin main; \
                pip install -r requirements.txt --no-warn-script-location; \
                python manage.py migrate; \
                deactivate; \
                sudo systemctl restart nginx; \
                sudo systemctl restart gunicorn "' 
            }
        }

        stage('Deploy to production') { 

            input {
                message "Should be deployed to production?"
                ok "Yes, deploy to prod!"
            }

            steps {
                sh 'ssh -o StrictHostKeyChecking=no deploy-user@49.50.69.229 "source env/bin/activate; \
                cd ciCdDemo; \
                git pull origin main; \
                pip install -r requirements.txt --no-warn-script-location; \
                python manage.py migrate; \
                deactivate; \
                sudo systemctl restart nginx; \
                sudo systemctl restart gunicorn "' 
            }
        }
    }
}