import requests
import time

BASE_URL = "http://localhost:8000"

def test_register():
    timestamp = int(time.time())
    username = f"backend_test_{timestamp}"
    email = f"backend_test_{timestamp}@example.com"
    password = "Password123!"
    
    payload = {
        "username": username,
        "email": email,
        "password": password,
        "password2": password,
        "first_name": "Backend",
        "last_name": "Tester",
        "country": "US"
    }
    
    print(f"Testing Register with: {username}")
    try:
        response = requests.post(f"{BASE_URL}/authentication/register/", json=payload)
        print(f"Register Status: {response.status_code}")
        print(f"Register Response: {response.text}")
        
        if response.status_code == 200 or response.status_code == 201:
            # Extract token
            import re
            match = re.search(r'token=([^ \n\']+)', response.text)
            if match:
                token = match.group(1)
                print(f"Found verification token: {token}")
                
                # Verify email
                verify_url = f"{BASE_URL}/authentication/email-verify/?token={token}"
                print(f"Verifying email at: {verify_url}")
                verify_response = requests.get(verify_url, allow_redirects=True)
                print(f"Verification Status: {verify_response.status_code}")
            else:
                print("Could not find verification token in response")
            
            return username, password
        return None, None
    except Exception as e:
        print(f"Register failed with exception: {e}")
        return None, None

def test_login(username, password):
    payload = {
        "username": username,
        "password": password
    }
    
    print(f"Testing Login with: {username}")
    try:
        response = requests.post(f"{BASE_URL}/authentication/login/", json=payload)
        print(f"Login Status: {response.status_code}")
        print(f"Login Response: {response.text}")
        
        if response.status_code == 200:
             print("LOGIN SUCCESSFUL!")
    except Exception as e:
        print(f"Login failed with exception: {e}")

if __name__ == "__main__":
    print("--- Starting Backend API Tests ---")
    user, pwd = test_register()
    if user:
        test_login(user, pwd)
    print("--- Finished Backend API Tests ---")
