import { defineStore } from 'pinia';

export const useGoogleAPIStore = defineStore({
    id: 'googleAPIStore',
    state: () => ({
        book_titles: [],
        book_authors: [],
        book_description: '',
        book_cover_url: '',
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
        async getBookDetailsFromTitle(bookTitle, languageCode) {
            if (!bookTitle) {
                this.book_authors = [];
                this.book_description = '';
                this.book_cover_url = '';
                return;
            }
            try {
                const data = await $fetch(
                    'https://www.googleapis.com/books/v1/volumes?q=' + encodeURIComponent(bookTitle) +
                    '&maxResults=1&projection=full&langRestrict=' + languageCode
                );

                if (data && data["items"] && data["items"].length > 0) {
                    const info = data["items"][0].volumeInfo;
                    this.book_authors = info.authors || [];
                    this.book_description = info.description || '';

                    // Prefer larger images if available
                    if (info.imageLinks) {
                        this.book_cover_url = info.imageLinks.thumbnail || info.imageLinks.smallThumbnail || '';
                        // Google Books URLs often use http, convert to https to avoid mixed content
                        if (this.book_cover_url) {
                            this.book_cover_url = this.book_cover_url.replace('http://', 'https://');
                        }
                    } else {
                        this.book_cover_url = '';
                    }
                } else {
                    this.book_authors = [];
                    this.book_description = '';
                    this.book_cover_url = '';
                }
            } catch (error) {
                console.error("Get book details failed:", error);
                this.book_authors = [];
                this.book_description = '';
                this.book_cover_url = '';
            }
        },
        async getBookAuthorsFromTitle(bookTitle, languageCode) {
            await this.getBookDetailsFromTitle(bookTitle, languageCode);
        },
    },
    getters: {},
});

//ToDo: 
// 1. set language of search in google api  - SOLUTION:  langRestrict
// 2. set max results in google api