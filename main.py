from fastapi import FastAPI

app = FastAPI(
    title="FastAPI Demo",
    description="A simple FastAPI application",
    version="0.1.0"
)

@app.get("/hello")
async def hello():
    return {"message": "Hello World"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)