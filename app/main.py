from fastapi import FastAPI
from app.routers import hello_world, health_check

app = FastAPI(
    title="FastAPI API",
    description="A simple FastAPI application",
    version="0.1.0"
)

app.include_router(hello_world.router)
app.include_router(health_check.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)