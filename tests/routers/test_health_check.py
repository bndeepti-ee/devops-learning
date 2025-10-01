from fastapi.testclient import TestClient
from app.main import app
import re

client = TestClient(app)

def test_health_check_endpoint():
    response = client.get("/health")
    assert response.status_code == 200
    
    data = response.json()
    assert "status" in data
    assert "timestamp" in data
    
    assert data["status"] == "Healthy"
    
    timestamp_pattern = r"^\d{2}-\d{2}-\d{4}T\d{2}:\d{2}:\d{2}Z$"
    assert re.match(timestamp_pattern, data["timestamp"]) is not None