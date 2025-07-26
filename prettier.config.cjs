/** @type {import('prettier').Config} */
module.exports = {
  semi: true,
  singleQuote: true,
  printWidth: 100,
  trailingComma: 'es5',
  arrowParens: 'always',
  tabWidth: 2,
  endOfLine: 'lf',
  bracketSpacing: true,
  overrides: [
    {
      files: '*.json',
      options: { printWidth: 120 },
    },
  ],
};