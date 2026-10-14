-- NUTRELLE – run this ONCE in Supabase: SQL Editor > New query > paste > Run

create extension if not exists pgcrypto;

create table if not exists public.products (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  category    text not null default 'Other',
  status      text not null default 'Available',
  pack        text,
  description text not null,
  details     text[] not null default '{}',
  images      text[] not null default '{}',
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

alter table public.products enable row level security;

drop policy if exists "Anyone can read products" on public.products;
drop policy if exists "Admin can add products" on public.products;
drop policy if exists "Admin can edit products" on public.products;
drop policy if exists "Admin can delete products" on public.products;

create policy "Anyone can read products" on public.products for select using (true);
create policy "Admin can add products"   on public.products for insert to authenticated with check (true);
create policy "Admin can edit products"  on public.products for update to authenticated using (true) with check (true);
create policy "Admin can delete products" on public.products for delete to authenticated using (true);

-- Image storage (public bucket, only signed-in admin can change files)
insert into storage.buckets (id, name, public)
values ('product-images', 'product-images', true)
on conflict (id) do nothing;

drop policy if exists "Anyone can view product images" on storage.objects;
drop policy if exists "Admin can upload product images" on storage.objects;
drop policy if exists "Admin can update product images" on storage.objects;
drop policy if exists "Admin can delete product images" on storage.objects;

create policy "Anyone can view product images" on storage.objects for select using (bucket_id = 'product-images');
create policy "Admin can upload product images" on storage.objects for insert to authenticated with check (bucket_id = 'product-images');
create policy "Admin can update product images" on storage.objects for update to authenticated using (bucket_id = 'product-images') with check (bucket_id = 'product-images');
create policy "Admin can delete product images" on storage.objects for delete to authenticated using (bucket_id = 'product-images');

-- First product (uses the image in your assets folder)
insert into public.products (name, category, status, pack, description, details, images)
select 'Enteriva Advanced Nutritional Gel', 'Nutrition', 'New Launch', '10 g single-serve sachet',
       'A nutritional gel presented in a convenient single-serve sachet, featuring flaxseed, psyllium, and turmeric on the product label.',
       array['Pack size: 10 g single-serve sachet','Visible ingredients: flaxseed, psyllium, and turmeric','Product label includes dietary fibre and plant-based nutrition messaging'],
       array['assets/enteriva-product.jpeg']
where not exists (select 1 from public.products);
