import requests
import sys
import time
import re

def test_health_endpoint(base_url):
    endpoint = f"{base_url}/health"
    print(f"Testing health endpoint: {endpoint}")
    
    try:
        response = requests.get(endpoint, timeout=5)
        assert response.status_code == 200, f"Health endpoint returned status code {response.status_code}, expected 200"
        
        data = response.json()
        timestamp_pattern = r"^\d{2}-\d{2}-\d{4}T\d{2}:\d{2}:\d{2}Z$"
        assert re.match(timestamp_pattern, data.get("timestamp", "")), f"Invalid timestamp format: {data.get('timestamp', 'missing')}"
        
        return True
            
    except AssertionError as e:
        print(f"Assertion failed: {str(e)}")
        return False

def test_docs_endpoint(base_url):
    endpoint = f"{base_url}/docs"
    print(f"Testing docs endpoint: {endpoint}")
    
    try:
        response = requests.get(endpoint, timeout=5)
        assert response.status_code == 200, f"Docs endpoint returned status code {response.status_code}, expected 200"
        return True
            
    except AssertionError as e:
        print(f"Assertion failed: {str(e)}")
        return False

def run_smoke_tests(base_url):
    print(f"Running smoke tests against {base_url}")
    
    print("Waiting 5 seconds for service to be ready...")
    time.sleep(5)
    
    tests = [
        test_health_endpoint,
        test_docs_endpoint
    ]
    
    results = []
    for test in tests:
        results.append(test(base_url))
    
    passed = all(results)
    total = len(results)
    passed_count = sum(results)
    
    print(f"Smoke tests: {passed_count}/{total} passed")
    return passed

base_url = "http://devops-learning.app"

if __name__ == "__main__":
    success = run_smoke_tests(base_url)
    sys.exit(0 if success else 1)