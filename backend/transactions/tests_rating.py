from rest_framework.test import APITestCase
from django.contrib.auth.models import User
from authentication.models import BookReader
from boookzdata.models import Book, BookShelf, Category, Author, BookCondition
from transactions.models import Transaction, TransactionStatus
from django.urls import reverse
import uuid

class RateTransactionTest(APITestCase):
    def setUp(self):
        # Create Users
        self.user1 = User.objects.create_user(username='user1', password='password123')
        self.user2 = User.objects.create_user(username='user2', password='password123')
        
        # Create BookReaders
        self.reader1 = BookReader.objects.create(user=self.user1)
        self.reader2 = BookReader.objects.create(user=self.user2)

        # Create Dependencies
        self.shelf = BookShelf.objects.create(shelf_name="giveaway")
        self.category = Category.objects.create(name="Fiction")
        self.author = Author.objects.create(name="Test Author")
        self.condition = BookCondition.objects.create(name="New")

        # Create Books
        self.book1 = Book.objects.create(
            name="Book 1", 
            book_reader=self.reader1, 
            book_shelf=self.shelf,
            category=self.category,
            author=self.author,
            condition=self.condition
        )
        self.book2 = Book.objects.create(
            name="Book 2", 
            book_reader=self.reader2, 
            book_shelf=self.shelf,
            category=self.category,
            author=self.author,
            condition=self.condition
        )

        # Create Transaction Status
        self.status_completed = TransactionStatus.objects.create(name="Completed")
        self.status_initiated = TransactionStatus.objects.create(name="Initiated")

        # Create Transaction
        self.token = uuid.uuid4()
        self.transaction = Transaction.objects.create(
            token=self.token,
            book_reader_initiator=self.reader1,
            book_reader_receiver=self.reader2,
            initiator_book=self.book1,
            receiver_book=self.book2,
            transaction_status=self.status_completed
        )

    def test_rate_transaction_success(self):
        self.client.force_authenticate(user=self.user1)
        url = reverse('rate_transaction', kwargs={'transaction_token': self.token})
        data = {
            "rating": 5,
            "comment": "Great trade!"
        }
        response = self.client.post(url, data)
        self.assertEqual(response.status_code, 200)
        self.assertIn("created successfully", str(response.data))

    def test_rate_transaction_bad_status(self):
        # Change status to Initiated
        self.transaction.transaction_status = self.status_initiated
        self.transaction.save()

        self.client.force_authenticate(user=self.user1)
        url = reverse('rate_transaction', kwargs={'transaction_token': self.token})
        data = {
            "rating": 5,
            "comment": "Premature rating"
        }
        response = self.client.post(url, data)
        # Should verify receiving error or handled failure
        self.assertEqual(response.status_code, 200) # The view returns 200 with error key as per analysis
        self.assertIn("error", response.data)
