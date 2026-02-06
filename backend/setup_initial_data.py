
import os
import django
import sys

# Setup Django environment
sys.path.append('/app/backend')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'boookz.settings')
django.setup()

from boookzdata.models import BookCondition, BookShelf

def setup_data():
    # 1. Book Conditions
    conditions = ["Good", "Bad", "Perfect"]
    for name in conditions:
        obj, created = BookCondition.objects.get_or_create(name=name)
        if created:
            print(f"Created BookCondition: {name}")
        else:
            print(f"BookCondition already exists: {name}")

    # 2. Book Shelves
    shelves = ["giveaway", "wanted"]
    for name in shelves:
        obj, created = BookShelf.objects.get_or_create(shelf_name=name)
        if created:
            print(f"Created BookShelf: {name}")
        else:
            print(f"BookShelf already exists: {name}")

if __name__ == "__main__":
    setup_data()
