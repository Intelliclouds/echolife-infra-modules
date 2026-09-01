import os
import json
import boto3
import string
import secrets
import pg8000.native # Pure Python Postgres driver

def lambda_handler(event, context):
    ssm_client = boto3.client('ssm')
    param_name = os.environ['SSM_PARAM_NAME']
    db_host = os.environ['DB_HOST'].split(':')[0]
    
    # 1. Fetch current credentials
    response = ssm_client.get_parameter(Name=param_name, WithDecryption=True)
    creds = json.loads(response['Parameter']['Value'])
    username = creds['username']
    current_password = creds['password']
    
    # 2. Generate new 32-character secure password
    alphabet = string.ascii_letters + string.digits
    new_password = ''.join(secrets.choice(alphabet) for i in range(32))
    
    # 3. Connect to RDS and update password
    con = pg8000.native.Connection(
        user=username, 
        password=current_password, 
        host=db_host, 
        database='postgres'
    )
    con.run(f"ALTER USER {username} WITH PASSWORD '{new_password}';")
    con.close()
    
    # 4. Update SSM Parameter Store with new password
    new_creds = {"username": username, "password": new_password}
    ssm_client.put_parameter(
        Name=param_name,
        Value=json.dumps(new_creds),
        Type='SecureString',
        Overwrite=True
    )
    
    return {"status": "success", "user": username}
