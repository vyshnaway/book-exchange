#!/bin/bash
set -e

# Wait for database
python << END
import sys
import time
import os
import psycopg2

dbname = os.environ.get("POSTGRES_DB")
user = os.environ.get("POSTGRES_USER")
password = os.environ.get("POSTGRES_PASSWORD")
host = os.environ.get("POSTGRES_HOST")
port = os.environ.get("POSTGRES_PORT", "5432")

if not all([dbname, user, password, host]):
    print("Database configuration missing, skipping wait")
    sys.exit(0)

print(f"Waiting for database at {host}:{port}...")
for i in range(30):
    try:
        conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
        conn.close()
        print("Database available")
        sys.exit(0)
    except psycopg2.OperationalError:
        time.sleep(1)

print("Database timed out")
sys.exit(1)
END

echo "Collect static files"
python manage.py collectstatic --noinput

echo "Apply database migrations"
python manage.py makemigrations
python manage.py migrate

echo "Creating superuser if needed"
python << END
import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'boookz.settings')
django.setup()
from django.contrib.auth import get_user_model
User = get_user_model()
username = os.environ.get("DJANGO_SUPERUSER_USERNAME", "admin")
email = os.environ.get("DJANGO_SUPERUSER_EMAIL", "admin@example.com")
password = os.environ.get("DJANGO_SUPERUSER_PASSWORD", "admin")
if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
    print(f"Superuser {username} created")
END

# Execute the command passed to docker run
exec "$@"
