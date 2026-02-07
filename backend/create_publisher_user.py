

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

def create_and_verify_user():
    username = "test_publisher"
    email = "test_publisher@example.com"
    password = "Password123!"

    # 1. Clean up existing user if any
    try:
        user = User.objects.get(username=username)
        print(f"User {username} exists. Deleting...")
        user.delete()
    except User.DoesNotExist:
        pass

    # 2. Create User via ORM
    print(f"Creating {username} via ORM...")
    user = User.objects.create_user(username=username, email=email, password=password)
    user.first_name = "Test"
    user.last_name = "Publisher"
    user.save()

    # 3. Ensure BookReader exists and is verified
    # Signals might have created it, but let's be safe
    book_reader, created = BookReader.objects.get_or_create(user=user)
    book_reader.country = "USA"
    book_reader.is_verified = True
    book_reader.save()

    print(f"User {username} created and manually verified in DB.")
    return True

if __name__ == "__main__":
    create_and_verify_user()

