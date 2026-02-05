/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './nuxt.config.{js,ts}',
    './app.vue',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#1e293b', // Deep Navy
        secondary: '#475569', // Slate
        accent: '#f59e0b', // Amber/Gold
        background: '#f8fafc', // Off-white
        surface: '#ffffff',
      },
    },
  },
  plugins: [],
};
