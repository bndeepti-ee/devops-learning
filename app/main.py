from fastapi import FastAPI
from app.routers import health_check, metrics
from app.monitoring import PrometheusMiddleware

app = FastAPI(
    title="Devops Learning API",
    description="A simple Devops Learning web application",
    version="0.1.0"
)

app.add_middleware(PrometheusMiddleware)

app.include_router(health_check.router)
app.include_router(metrics.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)