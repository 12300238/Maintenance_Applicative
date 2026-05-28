from pydantic import BaseModel


class Config(BaseModel):
    CORS_ALLOWED_IPS: list[str] = [
        "*"
    ]


settings = Config()

