import { defineStore } from 'pinia';
import { getNames, getCode, getName } from 'country-list';

export const useCountryStore = defineStore({
    id: 'countryStore',
    state: () => ({
        countries: [],
        chosenCountryCode: '',
        chosenCountryName: ''
    }),
    actions: {
        getAllCountries() {
            try {
                console.log("getAllCountries called. getNames:", getNames);
                const names = getNames();
                console.log("getNames result length:", names ? names.length : 'null');
                this.countries = names.sort();
                return this.countries;
            } catch (e) {
                console.error("Error in getAllCountries:", e);
                return [];
            }
        },

        chooseCountry(countryName) {
            this.chosenCountryName = countryName;
            this.chosenCountryCode = getCode(countryName);
        },

        setCountryByCode(code) {
            if (!code) return;
            this.chosenCountryCode = code;
            this.chosenCountryName = getName(code);
        }
    },
});
