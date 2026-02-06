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
    searchResults: [],
  }),
  actions: {
    async getWantedBooksFromDB(countryCode = null, showOwnBooks = true) {
      const res = await $fetch(this.BE_API + 'data/wanted/');
      const userStore = useUserStore();

      const targetCountry = countryCode;
      let filteredRes = res;

      if (targetCountry) {
        filteredRes = filteredRes.filter(item => {
          return (item.book_owner.country === targetCountry)
        })
      }

      if (userStore.userIsLoggedIn && !showOwnBooks) {
        filteredRes = filteredRes.filter(item => {
          return (item.book_owner.username !== userStore.userName)
        })
      }

      this.wantedBooks = filteredRes;
    },

    async getOfferedBooksFromDB(countryCode = null, showOwnBooks = true) {
      const res = await $fetch(this.BE_API + 'data/giveaway/');
      const userStore = useUserStore();

      const targetCountry = countryCode;
      let filteredRes = res;

      if (targetCountry) {
        filteredRes = filteredRes.filter(item => {
          return (item.book_owner.country === targetCountry)
        })
      }

      if (userStore.userIsLoggedIn && !showOwnBooks) {
        filteredRes = filteredRes.filter(item => {
          return (item.book_owner.username !== userStore.userName)
        })
      }

      this.giveAwayBooks = filteredRes;
      this.randomBook = this.giveAwayBooks[Math.floor(Math.random(1) * this.giveAwayBooks.length)];
    },
    setClickedBook(book) {
      this.clickedBook = book;
      this.persist
    },

    async searchForBook(book_title) {
      const res = await $fetch(this.BE_API + 'data/search?search=' + book_title);
      this.searchResults = res;
      await navigateTo("/SearchResults")
    },


    async updateData() {
      await this.getWantedBooksFromDB();
      await this.getOfferedBooksFromDB();
    }

  },

  //to get specific parts of data, like select <items> from <container> WHERE <condition>
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


