import os
import django
import random

# Setup Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'boookz.settings')
django.setup()

from django.contrib.auth.models import User
from authentication.models import BookReader
from django.core.files.base import ContentFile

def create_test_user(username, password, first_name):
    if User.objects.filter(username=username).exists():
        print(f"User {username} already exists")
        user = User.objects.get(username=username)
        user.set_password(password)
        user.save()
    else:
        user = User.objects.create_user(username=username, password=password, email=f"{username}@example.com")
        user.first_name = first_name
        user.save()
        print(f"User {username} created")

    # Verify Profile
    try:
        profile = user.bookreader
        profile.is_verified = True
        profile.country = 'US' # Default to US for testing
        profile.save()
        print(f"Profile for {username} verified")
    except Exception as e:
        print(f"Error verifying profile: {e}")

create_test_user('test_alice', 'password123', 'Alice')
create_test_user('test_bob', 'password123', 'Bob')
