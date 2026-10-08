-- 플랜두씨 다이어리 2: 내 자료만 읽고·쓰고·지우게 막는 규칙 (Supabase SQL Editor에서 실행)
create table if not exists public.diary (
  user_id uuid primary key references auth.users(id) on delete cascade,
  state jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.diary enable row level security;

create policy "내 자료만 읽기" on public.diary for select using (auth.uid() = user_id);
create policy "내 자료만 만들기" on public.diary for insert with check (auth.uid() = user_id);
create policy "내 자료만 고치기" on public.diary for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "내 자료만 지우기" on public.diary for delete using (auth.uid() = user_id);
