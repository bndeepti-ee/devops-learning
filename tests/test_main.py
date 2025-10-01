from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_nonexistent_endpoint():
    """Test that a nonexistent endpoint returns a 404 status code."""
    response = client.get("/nonexistent")
    assert response.status_code == 404