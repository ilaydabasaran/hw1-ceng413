# Homework Web Application

Build: `docker build -t myapp:1.0 .`
Run: `docker run -d -p 8000:8000 -v mydata:/data --name myapp myapp:1.0`
Test: `curl http://localhost:8000/health`
Stop: `docker rm -f myapp`