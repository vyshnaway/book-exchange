import os
import django
import sys

# Setup Django environment
sys.path.append('/app/backend')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'boookz.settings')
django.setup()

from boookzdata.models import BookCondition, BookShelf, Category

def seed_data():
    # 1. Seed Book Conditions
    conditions = ['Bad', 'Good', 'Perfect']
    print("Seeding Book Conditions...")
    for cond_name in conditions:
        obj, created = BookCondition.objects.get_or_create(name=cond_name)
        if created:
            print(f" - Created condition: {cond_name}")
        else:
            print(f" - Condition exists: {cond_name}")

    # 2. Seed Book Shelves
    shelves = ['giveaway', 'wanted']
    print("\nSeeding Book Shelves...")
    for shelf_name in shelves:
        obj, created = BookShelf.objects.get_or_create(shelf_name=shelf_name)
        if created:
             print(f" - Created shelf: {shelf_name}")
        else:
             print(f" - Shelf exists: {shelf_name}")
    
    # 3. Seed Categories (Optional but helpful)
    categories = [
        'Fiction', 'Non-Fiction', 'Mystery', 'Science Fiction', 'Romance', 'Horror',
        'Self-Help', 'Fantasy', 'Historical', 'Biography', 'Autobiography', 'Memoir',
        'History', 'Science', 'Travel', 'Religion', 'Philosophy', 'Business', 'Cookbooks',
        'Diaries', 'Journals', 'Letters', 'Poetry', "Children's", 'Young Adult', 'Classics',
        'Comics', 'Graphic Novels', 'Textbooks', 'Academic', 'Professional', 'Technical',
        'Erotica', 'Crime', 'Thriller', 'Suspense', 'Western', 'Short Stories', 'Anthology',
        'Play', 'Scripts', 'Screenplays', 'Manga', 'Manhua', 'Manhwa', 'Self-Publishing', 'Indie',
    ]
    print("\nSeeding Categories...")
    for cat_name in categories:
        obj, created = Category.objects.get_or_create(name=cat_name)
        if created:
            # print(f" - Created category: {cat_name}") # Too verbose
            pass

    print("\nSeeding Complete! ✅")

if __name__ == "__main__":
    seed_data()
