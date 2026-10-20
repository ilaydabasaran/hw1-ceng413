# ---- Stage 1: build (installs dependencies) ----
FROM python:3.12-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---- Stage 2: final image (only what is needed to run) ----
FROM python:3.12-slim
WORKDIR /app

# Take the installed packages from the build stage
COPY --from=build /install /usr/local

# Create an unprivileged user and a data folder it can write to
RUN useradd --create-home --uid 10001 appuser \
    && mkdir -p /data \
    && chown appuser:appuser /data

# Copy the application code with non-root ownership
COPY --chown=appuser:appuser . .

USER appuser

ENV DATA_DIR=/data
EXPOSE 8000

# Bonus: periodically check the /health endpoint (no curl in slim, so we use Python)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]