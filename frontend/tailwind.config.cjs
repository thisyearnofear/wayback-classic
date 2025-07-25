/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{ts,tsx,html}"],
  theme: {
    extend: {
      fontFamily: {
        retro: ['"Press Start 2P"', "monospace"],
      },
      colors: {
        retroBg: "#eff0f2",
        retroHeader: "#3d4148",
        retroAccent: "#f8d347",
      },
      boxShadow: {
        retro: "0 0 0 2px #222, 0 6px 24px 0 rgba(0,0,0,.06)",
      },
    },
  },
  plugins: [],
};