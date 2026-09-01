-- =========================================================
-- Banco de dados do Agente IA Imobiliária (WhatsApp)
-- Rode este script no SQL Editor do seu projeto Supabase
-- =========================================================

-- Clientes que entraram em contato pelo WhatsApp
create table if not exists imob_clientes (
  id uuid primary key default gen_random_uuid(),
  nome text,
  telefone text unique not null,
  stage text not null default 'NOVO',           -- NOVO | ATENDIMENTO | VISITA_AGENDADA
  visita_agendada boolean not null default false,
  data_visita text,                              -- texto livre, ex: "quinta às 15h"
  criado_em timestamptz not null default now()
);

-- Histórico de mensagens (memória da conversa, usado para dar contexto ao GPT)
create table if not exists imob_mensagens (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references imob_clientes(id) on delete cascade,
  role text not null,        -- 'user' ou 'assistant'
  conteudo text,
  criado_em timestamptz not null default now()
);

-- Visitas agendadas (uma linha por visita confirmada)
create table if not exists imob_visitas (
  id uuid primary key default gen_random_uuid(),
  cliente_id uuid references imob_clientes(id) on delete cascade,
  imovel text not null default 'Apartamento Vila Madalena',
  data_hora text not null,   -- texto livre combinado com o cliente
  status text not null default 'AGENDADA', -- AGENDADA | REALIZADA | CANCELADA
  criado_em timestamptz not null default now()
);

create index if not exists idx_imob_mensagens_cliente on imob_mensagens(cliente_id);
create index if not exists idx_imob_visitas_cliente on imob_visitas(cliente_id);

-- Observação: o workflow n8n usa a Service Role Key (já configurada) para
-- acessar essas tabelas via REST, então RLS não precisa ser habilitado
-- (a service role sempre passa por cima do RLS). Se algum dia expuser
-- essas tabelas para o navegador/app do cliente, habilite RLS antes.
