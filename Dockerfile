# Use the official Python image as base
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV LLM_BASE_URL="https://llm.cvpchat.genai.cvpcorp.app/v1" \
    LLM_MODEL="Mixtral-8x7B" \
    LLM_API_KEY="franklin-f8a19babe952af63a6f673b4e6edb9a813a33e8bfe51363c161b9e4122fdc4b0629ed39d0cb253d6bc8cd82f1e2c6ab9fc72eefb673924d3e7f0a13966022f4838430615a57cb2a43f491dd94e454755dc7bd6aa7ee33d530e6265fabd90f3a35450e657458e11f547f2cec6d5d61f0f55e6b1c90e5ccd3cdf6d1fed8d7c53a7"  \
    AGENT_LOG_NAME="log.out" \
    JIRA_SERVER_URL="https://cvpcorp-dev.atlassian.net" \
    JIRA_USERNAME="michaelcrandall@cvpcorp.com" \
    JIRA_API_TOKEN="ATATT3xFfGF099jogZzn47tjicytqfXrS8sEt8eW2MkevTCgUWdVi629AQGENidk926YXLe_MQIkK_kxc92MsGk7-hAORbOSeZqGPHQR-8v4ZuHq0TiaLnfMydDWNgaytz-53Iex4RCqxZjrOw-UJcAakYIQVr3u_1DEauTsltzjK9QBlg00tqM=E0670EB1"

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY ./requirements.txt /app/

# Install any dependencies
RUN pip install --upgrade pip setuptools --break-system-packages
RUN pip install --no-cache-dir Flask[async]==3.0.2 \
    Markdown==3.6 \
    aiohttp==3.9.3 \
    regex==2023.12.25 \
    JIRA==3.8.0 \
    python-dotenv==1.0.1 

# Copy the current directory contents into the container at /app
COPY . /app/

# Expose port 5000 to allow communication to/from server
EXPOSE 5000

# Command to run the Flask application
CMD ["python", "app.py"]
