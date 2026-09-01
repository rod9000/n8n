const fs = require('fs');
const path = 'C:/Users/Usuario/Downloads/n8n/vendingmachine.json';
const raw = fs.readFileSync(path, 'utf8');

// Find all "jsCode" string values and fix their escaping
// Strategy: the file is mostly valid JSON except for jsCode strings
// that contain regex with \[ \s \] etc.

// We'll parse the JSON by fixing escape issues
// First, let's replace all invalid escape sequences

// In JSON strings, \X is only valid for: " \ / b f n r t u
// Any \X where X is not one of those is invalid
// We need to make them \\X so JSON stores literal \X for JS

let result = '';
let inString = false;
let i = 0;

while (i < raw.length) {
  const ch = raw[i];
  
  if (!inString) {
    result += ch;
    if (ch === '"') inString = true;
    i++;
  } else {
    if (ch === '\\') {
      const next = raw[i + 1];
      if ('"\\"\/bfnrtu'.includes(next)) {
        // Valid JSON escape - keep as is
        result += ch + next;
        i += 2;
      } else {
        // Invalid JSON escape - double the backslash
        result += '\\\\' + next;
        i += 2;
      }
    } else if (ch === '"') {
      result += ch;
      inString = false;
      i++;
    } else {
      result += ch;
      i++;
    }
  }
}

try {
  JSON.parse(result);
  console.log('JSON is VALID!');
  fs.writeFileSync(path, result, 'utf8');
  console.log('File saved: ' + path);
} catch(e) {
  console.log('ERROR:', e.message);
  const pos = parseInt(e.message.match(/position (\d+)/)?.[1] || '0');
  console.log('Context:', JSON.stringify(result.substring(Math.max(0,pos-50), pos+50)));
}
