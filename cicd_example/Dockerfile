FROM python:3.9-slim

COPY ./src /app/

WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

# Start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
