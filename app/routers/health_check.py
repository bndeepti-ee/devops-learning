from fastapi import APIRouter
from datetime import datetime, UTC

router = APIRouter()

@router.get("/health", tags=["health"])
async def health_check():
    return {
        "status": "Healthy",
        "timestamp": datetime.now(UTC).strftime("%d-%m-%YT%H:%M:%SZ")
    }