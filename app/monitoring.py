from prometheus_client import Counter, Histogram
from starlette.middleware.base import BaseHTTPMiddleware

REQUEST_TIME = Histogram(
    'request_processing_seconds', 
    'Time spent processing request',
    ['method', 'endpoint']
)

HEALTH_CHECK_CALLS = Counter(
    'health_check_requests_total',
    'Total number of health check endpoint calls'
)

def increment_health_check_counter():
    HEALTH_CHECK_CALLS.inc()

class PrometheusMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        method = request.method
        endpoint = request.url.path

        if endpoint == "/metrics":
            return await call_next(request)

        with REQUEST_TIME.labels(method=method, endpoint=endpoint).time():
            response = await call_next(request)

        return response