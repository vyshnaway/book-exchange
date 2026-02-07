import { defineStore } from 'pinia';

export const useGoogleAPIStore = defineStore({
    id: 'googleAPIStore',
    state: () => ({
        book_titles: [],
        book_authors: [],
        book_limit: 10,
    }),
    actions: {
        async searchForBookTitles(bookTitle, languageCode) {
            if (!bookTitle) {
                this.book_titles = [];
                return;
            }
            try {
                let url = 'https://www.googleapis.com/books/v1/volumes?q=' + encodeURIComponent(bookTitle) + '&maxResults=' + this.book_limit;
                if (languageCode) {
                    url += "&langRestrict=" + languageCode;
                }

                const data = await $fetch(url);
                this.book_titles = [];
                if (data && data["items"]) {
                    const uniqueTitles = new Set();
                    for (const item of data["items"]) {
                        if (item.volumeInfo && item.volumeInfo.title) {
                            if (!uniqueTitles.has(item.volumeInfo.title)) {
                                uniqueTitles.add(item.volumeInfo.title);
                                this.book_titles.push(item.volumeInfo.title);
                            }
                        }
                    }
                }
            } catch (error) {
                console.error("Search for book titles failed:", error);
                this.book_titles = [];
            }
        },
        async getBookAuthorsFromTitle(bookTitle, languageCode) {
            if (!bookTitle) {
                this.book_authors = [];
                return;
            }
            try {
                const data = await $fetch(
                    'https://www.googleapis.com/books/v1/volumes?q=' + encodeURIComponent(bookTitle) +
                    '&maxResults=1&projection=lite&langRestrict=' + languageCode
                );
                if (data && data["items"] && data["items"].length > 0) {
                    this.book_authors = data["items"].at(0).volumeInfo.authors || [];
                } else {
                    this.book_authors = [];
                }
            } catch (error) {
                console.error("Get book authors failed:", error);
                this.book_authors = [];
            }
        },
    },
    getters: {},
});

//ToDo: 
// 1. set language of search in google api  - SOLUTION:  langRestrict
// 2. set max results in google api