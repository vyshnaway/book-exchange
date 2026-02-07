import os
import django
import sys

# Setup Django environment
sys.path.append('/app/backend')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'boookz.settings')
django.setup()

from django.contrib.auth import get_user_model
from authentication.models import BookReader

User = get_user_model()

def create_demo_users():
    users = [
        {"username": "root", "password": "toor"},
        {"username": "dina", "password": "password!@#"},
        {"username": "yaroslav", "password": "password!@#"},
        {"username": "asser", "password": "password!@#"},
        {"username": "youssef", "password": "password!@#"},
        {"username": "andrii", "password": "password!@#"},
    ]

    print("Checking for demo users...")

    for user_data in users:
        username = user_data["username"]
        password = user_data["password"]

        try:
            user = User.objects.get(username=username)
            print(f"User {username} already exists. Skipping.")
        except User.DoesNotExist:
            print(f"Creating user {username}...")
            user = User.objects.create_user(username=username, password=password)
            user.save()
            print(f"User {username} created.")

        # Ensure BookReader profile exists and is verified
        # The post_save signal should handle creation, but we ensure verification here.
        try:
            book_reader, created = BookReader.objects.get_or_create(user=user)
            if not book_reader.is_verified:
                book_reader.is_verified = True
                book_reader.save()
                print(f"Verified profile for {username}.")
        except Exception as e:
            print(f"Error ensuring profile for {username}: {e}")

if __name__ == "__main__":
    create_demo_users()
