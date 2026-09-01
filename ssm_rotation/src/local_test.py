# ~/echolife-infra/modules/ssm_rotation/src/local_test.py
import os
import rotator

# Mock the Lambda environment variables
os.environ['SSM_PARAM_NAME'] = '/echolife/dev/rds/credentials'
os.environ['DB_HOST'] = 'localhost' # Pointing to your Docker container
os.environ['AWS_DEFAULT_REGION'] = 'ap-south-1' # Forces boto3 to use Mumbai

print("Starting local rotation test...")
try:
    response = rotator.lambda_handler({}, None)
    print("Lambda Response:", response)
except Exception as e:
    print("Error during execution:", str(e))
