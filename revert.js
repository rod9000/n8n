const fs = require('fs');
let c = fs.readFileSync('C:/Users/Usuario/Downloads/n8n/vendingmachine.json', 'utf8');
c = c.replace(/sbOSoQ9F1GhyG6TG/g, 'SUA_SUPABASE_SERVICE_ROLE_KEY');
c = c.replace(/GxBcr7nrFeZbnux8/g, 'SUA_GOOGLE_API_KEY');
c = c.replace(/DniXo7o00EeHyFtc/g, 'SUA_EVOLUTION_API_KEY');
c = c.replace(/https:\/\/dsxloquqjlpcqexuxilh\.supabase\.co/g, 'https://SEU_PROJETO.supabase.co');
c = c.replace(/https:\/\/evolution-api-production-829b\.up\.railway\.app/g, 'https://SUA_EVOLUTION_URL');
c = c.replace('"instanceId": "onvendingwa01"', '"instanceId": "SEU_N8N_INSTANCE_ID"');

// Revert Enviar Texto to evolution api node type
c = c.replace(
  /"name": "Enviar Texto",\s*"type": "n8n-nodes-base\.httpRequest"/g,
  '"name": "Enviar Texto",\n      "type": "n8n-nodes-evolution-api.evolutionApi"'
);

fs.writeFileSync('C:/Users/Usuario/Downloads/n8n/vendingmachine.json', c, 'utf8');
console.log('Revertido!');
