from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from core.config import settings


app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ALLOWED_IPS
)
