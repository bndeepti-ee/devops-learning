from fastapi import APIRouter
from datetime import datetime, UTC
from app.monitoring import increment_health_check_counter

router = APIRouter()

@router.get("/health", tags=["health"])
async def health_check():
    increment_health_check_counter()

    return {
        "status": "Healthy",
        "timestamp": datetime.now(UTC).strftime("%d-%m-%YT%H:%M:%SZ")
    }