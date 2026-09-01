const fs = require('fs');
const c = fs.readFileSync('C:/Users/Usuario/Downloads/n8n/vendingmachine.json', 'utf8');

// Find invalid JSON escape sequences
for (let i = 0; i < c.length; i++) {
  if (c[i] === '\\' && i + 1 < c.length) {
    const next = c[i + 1];
    if (!'"\b\f\n\r\\\/u'.includes(next)) {
      console.log('Invalid escape at pos', i, ': \\', next, '| context:', c.substring(Math.max(0, i - 20), i + 20));
    }
  }
}

// Try parse
try {
  JSON.parse(c);
  console.log('\nJSON is VALID');
} catch (e) {
  console.log('\nJSON ERROR:', e.message);
}
