from fastapi import FastAPI
from app.routers import health_check

app = FastAPI(
    title="FastAPI API",
    description="A simple FastAPI web application",
    version="0.1.0"
)

app.include_router(health_check.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)