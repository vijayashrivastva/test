# Use slim Python image
FROM python:3.11-slim

# Set work directory
WORKDIR /app

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project
COPY . .

# Create a non-root user
RUN useradd -m appuser
USER appuser

# Expose port
EXPOSE 8000

# Default command (use Procfile in ECS/Heroku)
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "0.0.0.0:8000"]
