import { defineStore } from 'pinia';
import { navigateTo } from "nuxt/app";
import { useUserStore } from './userStore';

export const useDataStore = defineStore({
  id: 'dataStore',
  state: () => ({
    wantedBooks: [],
    giveAwayBooks: [],
    randomBook: {},
    clickedBook: {},
    searchResults: [],
  }),
  actions: {
    async getWantedBooksFromDB(countryName = null, showOwnBooks = true) {
      const url = this.BE_API + 'data/wanted/';
      try {
        const res = await $fetch(url);
        const userStore = useUserStore();
        let filteredRes = res;

        // Filter by country name if provided
        if (countryName) {
          filteredRes = filteredRes.filter(item => {
            const bookCountry = item.book_owner?.country || '';
            return bookCountry.toLowerCase().includes(countryName.toLowerCase());
          });
        }

        if (userStore.userIsLoggedIn && !showOwnBooks) {
          filteredRes = filteredRes.filter(item => {
            return (item.book_owner.username !== userStore.userName)
          })
        }

        this.wantedBooks = filteredRes;
      } catch (err) {
        console.error(`[dataStore] Failed to fetch wanted books from ${url}:`, err);
        throw err;
      }
    },

    async getOfferedBooksFromDB(countryName = null, showOwnBooks = true) {
      const url = this.BE_API + 'data/giveaway/';
      try {
        const res = await $fetch(url);
        const userStore = useUserStore();
        let filteredRes = res;

        // Filter by country name if provided
        if (countryName) {
          filteredRes = filteredRes.filter(item => {
            // Case-insensitive string match on country name
            const bookCountry = item.book_owner?.country || '';
            return bookCountry.toLowerCase().includes(countryName.toLowerCase());
          });
        }

        if (userStore.userIsLoggedIn && !showOwnBooks) {
          filteredRes = filteredRes.filter(item => {
            return (item.book_owner.username !== userStore.userName)
          })
        }

        this.giveAwayBooks = filteredRes;
        this.randomBook = this.giveAwayBooks[Math.floor(Math.random(1) * this.giveAwayBooks.length)];
      } catch (err) {
        console.error(`[dataStore] Failed to fetch offered books from ${url}:`, err);
        throw err;
      }
    },

    setClickedBook(book) {
      this.clickedBook = book;
    },

    async searchForBook(book_title) {
      try {
        const res = await $fetch(this.BE_API + 'data/search?search=' + book_title);
        this.searchResults = res;
        await navigateTo("/SearchResults")
      } catch (err) {
        console.error(`[dataStore] Search failed for "${book_title}":`, err);
        throw err;
      }
    },

    async updateData() {
      await this.getWantedBooksFromDB();
      await this.getOfferedBooksFromDB();
    }
  },

  getters: {
    BE_API() {
      return (useRuntimeConfig().apiBase || useRuntimeConfig().public.apiBase).replace(/\/$/, '') + '/';
    }
  },

  persist: {
    enabled: true,
    storage: persistedState.localStorage,
  },
});
