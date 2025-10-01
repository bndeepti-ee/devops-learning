from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_hello_endpoint():
    """Test that the /hello endpoint returns the expected response."""
    response = client.get("/hello")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello World"}

def test_nonexistent_endpoint():
    """Test that a nonexistent endpoint returns a 404 status code."""
    response = client.get("/nonexistent")
    assert response.status_code == 404