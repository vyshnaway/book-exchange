<template>
  <div class="max-w-4xl mx-auto px-4 py-8">
    <div class="glass p-8 rounded-3xl shadow-premium">
      <div class="mb-10 text-center">
        <h1 class="text-4xl font-extrabold text-dark tracking-tight">{{ isEditMode ? 'Edit Book' : 'Add a New Book' }}</h1>
        <p class="text-slate-500 mt-2 font-medium italic">{{ isEditMode ? 'Update your book details' : 'Share your treasures with the community' }}</p>
      </div>

      <form @submit.prevent="addBook" enctype="multipart/form-data" class="flex flex-col gap-10">
        <!-- Basic Info Section -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <!-- Shelf Selection -->
          <div class="flex flex-col gap-2">
            <label for="shelf" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Shelf Location</label>
            <select
              id="shelf"
              v-model="bookForm.shelf"
              class="input-field cursor-pointer"
            >
              <option value="" disabled>- Select Shelf -</option>
              <option value="giveaway">Giveaway Shelf</option>
              <option value="wanted">Wanted Shelf</option>
            </select>
          </div>

          <!-- Language Selection -->
          <div class="flex flex-col gap-2">
            <label for="language" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Book Language</label>
            <select
              id="language"
              v-model="chosenLanguage"
              @change="getLangfullName"
              class="input-field cursor-pointer"
            >
              <option value="" disabled>- Select Language -</option>
              <option v-for="language in Languages" :key="language" :value="language">{{ language }}</option>
            </select>
          </div>
        </div>

        <!-- Title & Authors Section -->
        <div class="flex flex-col gap-6">
          <div class="flex flex-col gap-2">
            <label for="book-title" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Complete Book Title</label>
            <v-combobox
              id="book-title"
              v-model="bookForm.title"
              :items="suggestedTitles"
              @update:search="onSearchUpdate"
              @update:model-value="onBookSelect"
              placeholder="Start typing to get suggestions or enter manually..."
              variant="outlined"
              density="comfortable"
              class="premium-v-input"
              color="indigo-500"
              rounded="xl"
              hide-no-data
              menu-icon="mdi-chevron-down"
            />
          </div>

          <div class="flex flex-col gap-2">
            <div class="flex justify-between items-center mb-1">
              <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Author(s)</label>
              <button @click="addAuthorField" type="button" class="text-primary font-bold text-xs hover:underline">+ Add Another</button>
            </div>
            
            <div class="flex flex-col gap-3">
              <div v-for="(author_at, index) in bookForm.author" :key="index" class="flex gap-2 animate-in slide-in-from-left-2 duration-200">
                <input
                  v-model="bookForm.author[index]"
                  placeholder="Author Name"
                  class="input-field"
                />
                <button
                  type="button"
                  @click="deleteAuthorField(index)"
                  class="p-3 text-slate-300 hover:text-red-500 transition-colors"
                >
                  <font-awesome-icon icon="fa-solid fa-trash-can" />
                </button>
              </div>
              <p v-if="bookForm.author.length === 0" class="text-sm text-slate-400 italic">No authors added yet.</p>
            </div>
          </div>
        </div>

        <!-- Metadata Section -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div class="flex flex-col gap-2">
            <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Category(s)</label>
            <v-combobox
              v-model="bookForm.category"
              :items="categories"
              multiple
              variant="outlined"
              density="comfortable"
              placeholder="Select or type tags..."
              class="premium-v-input"
              rounded="xl"
              chips
              closable-chips
            />
          </div>

          <div class="flex flex-col gap-2">
            <label for="condition" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Book Condition</label>
            <select
              id="condition"
              v-model="bookForm.condition"
              class="input-field cursor-pointer"
            >
              <option value="" disabled>- Select Condition -</option>
              <option v-for="condition in conditions" :key="condition" :value="condition">{{ condition }}</option>
            </select>
          </div>
        </div>

        <!-- Description Section -->
        <div class="flex flex-col gap-2 animate-in fade-in slide-in-from-top-2 duration-500">
          <label for="description" class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">About the Book</label>
          <textarea
            id="description"
            v-model="bookForm.description"
            rows="4"
            placeholder="Tell us about this copy..."
            class="input-field min-h-[120px] py-4 resize-none"
          ></textarea>
          <p v-if="googleStore.book_description && bookForm.description === googleStore.book_description" class="text-[10px] text-primary/60 font-bold uppercase tracking-wider ml-1">
            <font-awesome-icon icon="fa-solid fa-wand-magic-sparkles" class="mr-1" />
            Auto-fetched from Library
          </p>
        </div>

        <!-- Image Upload Section -->
        <div class="flex flex-col gap-2">
          <label class="text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Upload Gallery</label>
          <div class="border-2 border-dashed border-slate-200 rounded-2xl p-8 hover:border-primary/50 transition-colors flex flex-col items-center gap-4 group cursor-pointer relative">
            <input
              id="book-images"
              type="file"
              multiple
              accept=".png, .jpg, .jpeg, .heic"
              @change="updateFiles($event.target.files)"
              class="absolute inset-0 opacity-0 cursor-pointer z-10"
            />
            <div class="w-12 h-12 bg-slate-50 rounded-full flex items-center justify-center text-slate-400 group-hover:bg-primary/10 group-hover:text-primary transition-all">
              <font-awesome-icon icon="fa-solid fa-cloud-arrow-up" class="text-xl" />
            </div>
            <div class="text-center">
              <p class="text-sm font-bold text-dark">Click to upload images</p>
              <p class="text-xs text-slate-400 mt-1">PNG, JPG or HEIC (Max 5MB per file)</p>
            </div>
          </div>

          <!-- File Preview List -->
          <div v-if="bookForm.image.length > 0" class="flex flex-col gap-2 mt-2">
             <div v-for="(file, index) in bookForm.image" :key="index" class="flex items-center justify-between p-3 bg-slate-50 rounded-xl border border-slate-100">
               <div class="flex items-center gap-3 overflow-hidden">
                 <div class="w-8 h-8 rounded-lg bg-indigo-100/50 flex items-center justify-center text-indigo-500 relative overflow-hidden">
                   <img v-if="file.previewUrl" :src="file.previewUrl" class="w-full h-full object-cover" />
                   <font-awesome-icon v-else icon="fa-solid fa-image" class="text-xs" />
                 </div>
                 <div class="flex flex-col min-w-0">
                   <span class="text-xs font-bold text-slate-700 truncate block max-w-[200px]">{{ file.name }}</span>
                   <span class="text-[10px] text-slate-400">{{ file.isAutoFetched ? 'Auto-fetched cover' : (file.size / 1024).toFixed(1) + ' KB' }}</span>
                 </div>
               </div>
               <button type="button" @click="removeImage(index)" class="p-2 text-slate-400 hover:text-red-500 transition-colors">
                 <font-awesome-icon icon="fa-solid fa-xmark" />
               </button>
             </div>
          </div>
        </div>

        <!-- Submit Button -->
        <div class="pt-6">
          <button type="submit" class="btn-primary w-full !rounded-2xl !py-4 shadow-xl flex items-center justify-center gap-3">
            <span>{{ isEditMode ? 'Update Book' : 'Publish to Community' }}</span>
            <font-awesome-icon :icon="isEditMode ? 'fa-solid fa-check' : 'fa-solid fa-paper-plane'" />
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
  import { useUserStore } from '~/stores/userStore';
  import { useLangAPIStore } from '~/stores/languagesStore';
  import { useGoogleAPIStore } from '~/stores/googleAPIStore';
  import { ref, reactive, onMounted } from 'vue';

  const userStore = useUserStore();
  const langStore = useLangAPIStore();
  const googleStore = useGoogleAPIStore();

  const Languages = langStore.getAllLanguages();
  const conditions = ['Bad', 'Perfect', 'Good'];
  const categories = [
    'Fiction', 'Non-Fiction', 'Mystery', 'Science Fiction', 'Romance', 'Horror',
    'Self-Help', 'Fantasy', 'Historical', 'Biography', 'Autobiography', 'Memoir',
    'History', 'Science', 'Travel', 'Religion', 'Philosophy', 'Business', 'Cookbooks',
    'Diaries', 'Journals', 'Letters', 'Poetry', "Children's", 'Young Adult', 'Classics',
    'Comics', 'Graphic Novels', 'Textbooks', 'Academic', 'Professional', 'Technical',
    'Erotica', 'Crime', 'Thriller', 'Suspense', 'Western', 'Short Stories', 'Anthology',
    'Play', 'Scripts', 'Screenplays', 'Manga', 'Manhua', 'Manhwa', 'Self-Publishing', 'Indie',
  ];

  const route = useRoute();
  const isEditMode = ref(false);
  const editBookId = ref(null);
  const chosenLanguage = ref('');
  const suggestedTitles = ref([]);

  const bookForm = reactive({
    title: '',
    author: [],
    category: [],
    condition: '',
    language: '',
    image: [], // Stores File objects
    description: 'some description',
    shelf: '',
  });

  // Check if we're in edit mode and load book data
  onMounted(async () => {
    // Ensure user data is loaded first
    if (!userStore.userIsLoggedIn || userStore.userGiveAwayBooks.length === 0 && userStore.userWantedBooks.length === 0) {
      await userStore.getUserInfo();
    }
    
    if (route.query.edit) {
      isEditMode.value = true;
      editBookId.value = route.query.edit;
      await loadBookData(editBookId.value);
    }
  });

  async function loadBookData(bookId) {
    console.log('Loading book data for ID:', bookId);
    console.log('Available books:', {
      giveaway: userStore.userGiveAwayBooks.length,
      wanted: userStore.userWantedBooks.length
    });
    
    // Find the book in the user's books
    const allBooks = [...userStore.userGiveAwayBooks, ...userStore.userWantedBooks];
    const book = allBooks.find(b => b.pk == bookId);
    
    console.log('Found book:', book);
    
    if (book) {
      bookForm.title = book.title || '';
      
      // Handle author - could be array or comma-separated string
      if (Array.isArray(book.author)) {
        bookForm.author = book.author;
      } else if (typeof book.author === 'string') {
        bookForm.author = book.author.split(',').map(a => a.trim());
      } else {
        bookForm.author = [];
      }
      
      // Handle category - could be array or comma-separated string
      if (Array.isArray(book.category)) {
        bookForm.category = book.category;
      } else if (typeof book.category === 'string') {
        bookForm.category = book.category.split(',').map(c => c.trim());
      } else {
        bookForm.category = [];
      }
      
      bookForm.condition = book.condition || '';
      bookForm.language = book.language || '';
      bookForm.description = book.description || 'some description';
      
      // Determine shelf based on which array the book is in
      if (userStore.userGiveAwayBooks.find(b => b.pk == bookId)) {
        bookForm.shelf = 'giveaway';
      } else if (userStore.userWantedBooks.find(b => b.pk == bookId)) {
        bookForm.shelf = 'wanted';
      }
      
      // Set language dropdown
      if (book.language) {
        chosenLanguage.value = book.language;
        langStore.chooseLanguage(book.language);
      }
      
      console.log('Book form populated:', bookForm);
    } else {
      console.error('Book not found with ID:', bookId);
    }
  }

  const { $toast } = useNuxtApp();

  async function getTitleUsingGoogleAPI(title) {
    const languageCode = langStore.chosenLangCode;
    if (title && title.length > 2) {
      await googleStore.searchForBookTitles(title, languageCode);
      suggestedTitles.value = googleStore.book_titles;
    } else {
      suggestedTitles.value = [];
    }
  }

  let debounceTimeout = null;
  function onSearchUpdate(search) {
    // If the search string is exactly the same as the selected book title, 
    // it likely means the user just selected an item. Don't trigger a new search.
    if (search === bookForm.title) return;

    if (debounceTimeout) clearTimeout(debounceTimeout);
    debounceTimeout = setTimeout(() => {
      getTitleUsingGoogleAPI(search);
    }, 500);
  }

  async function onBookSelect(title) {
    if (!title) return;
    const languageCode = langStore.chosenLangCode;
    
    // $toast.info('Fetching details from Google Books...');
    await googleStore.getBookDetailsFromTitle(title, languageCode);
    
    // Populate authors and description
    bookForm.author = googleStore.book_authors;
    if (googleStore.book_description) {
      bookForm.description = googleStore.book_description;
    }
    
    // Fetch and attach cover image
    if (googleStore.book_cover_url) {
      await fetchAndAttachCover(googleStore.book_cover_url, title);
    }
  }

  async function fetchAndAttachCover(url, title) {
    try {
      const response = await fetch(url);
      const blob = await response.blob();
      
      // Create a file object from the blob
      const fileName = `${title.replace(/[^a-z0-9]/gi, '_').toLowerCase()}_cover.jpg`;
      const file = new File([blob], fileName, { type: 'image/jpeg' });
      
      // Add custom properties for UI feedback
      file.previewUrl = url;
      file.isAutoFetched = true;
      
      // Check if we already have an auto-fetched image and replace it
      const autoFetchedIndex = bookForm.image.findIndex(img => img.isAutoFetched);
      if (autoFetchedIndex !== -1) {
        bookForm.image.splice(autoFetchedIndex, 1, file);
      } else {
        // Add to the beginning of the gallery
        bookForm.image.unshift(file);
      }
      
      $toast.success('Cover image auto-fetched!');
    } catch (error) {
      console.error('Failed to fetch cover image:', error);
      // $toast.error('Could not fetch book cover automatically.');
    }
  }

  function getLangfullName() {
    langStore.chooseLanguage(chosenLanguage.value);
    bookForm.language = langStore.chosenLangEnglishName;
  }

  function updateFiles(files) {
    if (!files.length) return;
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        // Generate preview URL for local files
        file.previewUrl = URL.createObjectURL(file);
        bookForm.image.push(file);
    }
    // Clear the input so the user can select the same file again if needed
    const input = document.getElementById('book-images');
    if (input) input.value = '';
  }
  
  function removeImage(index) {
    bookForm.image.splice(index, 1);
  }

  async function addBook() {
    if (!bookForm.shelf) {
      $toast.error('Please select a shelf location');
      return;
    }
    
    // Only require images for new books, not edits
    if (!isEditMode.value && bookForm.image.length === 0) {
      $toast.error('Please upload at least one image');
      return;
    }

    const fd = new FormData();
    fd.append('title', bookForm.title);
    fd.append('author', bookForm.author.join(','));
    fd.append('category', bookForm.category.join(','));
    fd.append('condition', bookForm.condition);
    fd.append('language', bookForm.language);
    fd.append('description', bookForm.description);
    
    // Append images only if new ones were selected
    for (const file of bookForm.image) {
        fd.append('image', file);
    }

    if (isEditMode.value) {
      // Update existing book
      await userStore.updateBook(editBookId.value, fd, bookForm.shelf);
      if (userStore.updateBookSuccessful) {
        $toast.success('Book successfully updated!');
        await navigateTo('/profile');
      }
    } else {
      // Add new book
      await userStore.addBook(fd, bookForm.shelf);
      if (userStore.addBookSuccessfull) {
        $toast.success('Book successfully published!');
        await navigateTo('/profile');
      }
    }
  }

  function addAuthorField() {
    bookForm.author.push('');
  }

  function deleteAuthorField(index) {
    bookForm.author.splice(index, 1);
  }
</script>

<style>
/* Custom styles for Vuetify components to match Tailwind premium look */
.premium-v-input .v-field--outlined {
    @apply border-slate-200 rounded-xl !important;
}
.premium-v-input .v-field__outline {
    @apply hidden !important;
}
.premium-v-input .v-field {
    @apply border border-slate-200 rounded-xl transition-all !important;
    background: white !important;
    box-shadow: none !important;
}
.premium-v-input .v-field--focused {
    @apply border-primary ring-2 ring-primary/20 !important;
}
.premium-v-input .v-input__details {
    @apply hidden !important;
}
.premium-v-input .v-field__input {
    @apply min-h-[44px] py-2 !important;
}
</style>
