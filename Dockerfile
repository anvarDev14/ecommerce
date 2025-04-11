# Engil Python imidjidan foydalanish
FROM python:3.11-slim

# Ish muhitini o‘rnatish
WORKDIR /app

# Python muhit o‘zgaruvchilari
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DJANGO_SETTINGS_MODULE=ecommerce.settings

# Kerakli tizim paketlarini o‘rnatish
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Talablarni o‘rnatish
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Loyiha fayllarini nusxalash
COPY . .

# STATIC_ROOT va MEDIA_ROOT jildlarini yaratish
RUN mkdir -p /app/staticfiles /app/media \
    && chown -R nobody:nogroup /app/staticfiles /app/media \
    && chmod -R 755 /app/staticfiles /app/media

# Portni ochish
EXPOSE 8004