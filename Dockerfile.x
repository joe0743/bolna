FROM python:3.11-slim

WORKDIR /app

# Install system dependencies (including ffmpeg for pydub)
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

EXPOSE $PORT

CMD ["python", "-m", "uvicorn", "bolna.main:app", "--host", "0.0.0.0", "--port", "$PORT"]