-- RISHU MEDICAL AND HEALTHCARE ERP - Cloud Sync schema
-- Run this once in Supabase SQL Editor.
create table if not exists public.erp_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.erp_state enable row level security;

revoke all on table public.erp_state from anon;
grant select, insert, update, delete on table public.erp_state to authenticated;

drop policy if exists "erp_state_select_own" on public.erp_state;
drop policy if exists "erp_state_insert_own" on public.erp_state;
drop policy if exists "erp_state_update_own" on public.erp_state;
drop policy if exists "erp_state_delete_own" on public.erp_state;

create policy "erp_state_select_own" on public.erp_state
  for select to authenticated using (auth.uid() = user_id);
create policy "erp_state_insert_own" on public.erp_state
  for insert to authenticated with check (auth.uid() = user_id);
create policy "erp_state_update_own" on public.erp_state
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "erp_state_delete_own" on public.erp_state
  for delete to authenticated using (auth.uid() = user_id);

-- Optional: keep updated_at current whenever a row changes.
create or replace function public.erp_state_set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_erp_state_updated_at on public.erp_state;
create trigger trg_erp_state_updated_at
before update on public.erp_state
for each row execute function public.erp_state_set_updated_at();
