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
            this.countries = getNames().sort();
            return this.countries;
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
