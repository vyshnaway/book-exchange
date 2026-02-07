const { getNames, getCode, getName } = require('country-list');

console.log("Testing country-list library...");

const names = getNames();
console.log(`Total countries: ${names.length}`);
console.log("First 5 countries:", names.slice(0, 5));

const testCountry = "Germany";
const code = getCode(testCountry);
console.log(`Code for ${testCountry}:`, code);

const backToName = getName(code);
console.log(`Name for ${code}:`, backToName);

if (!code) {
    console.error("FAILED to get code for Germany");
} else {
    console.log("SUCCESS");
}
