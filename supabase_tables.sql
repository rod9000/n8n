-- Tabela de Clientes OnVending
CREATE TABLE IF NOT EXISTS onvending_clientes (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nome TEXT,
  telefone TEXT UNIQUE,
  stage TEXT DEFAULT 'BOAS_VINDAS',
  empresa TEXT,
  tipo_pessoa TEXT,
  visita_agendada BOOLEAN DEFAULT false,
  data_visita TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Tabela de Mensagens
CREATE TABLE IF NOT EXISTS onvending_mensagens (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  cliente_id UUID REFERENCES onvending_clientes(id),
  role TEXT,
  conteudo TEXT,
  criado_em TIMESTAMPTZ DEFAULT now()
);

-- Tabela de Visitas
CREATE TABLE IF NOT EXISTS onvending_visitas (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  cliente_id UUID REFERENCES onvending_clientes(id),
  tipo TEXT,
  data_hora TEXT,
  status TEXT DEFAULT 'AGENDADA',
  observacoes TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Habilitar RLS (Row Level Security)
ALTER TABLE onvending_clientes ENABLE ROW LEVEL SECURITY;
ALTER TABLE onvending_mensagens ENABLE ROW LEVEL SECURITY;
ALTER TABLE onvending_visitas ENABLE ROW LEVEL SECURITY;

-- Criar policies para acesso via service_role
CREATE POLICY "Acesso total via service_role" ON onvending_clientes FOR ALL USING (true);
CREATE POLICY "Acesso total via service_role" ON onvending_mensagens FOR ALL USING (true);
CREATE POLICY "Acesso total via service_role" ON onvending_visitas FOR ALL USING (true);
