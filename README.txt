NUTRELLE WEBSITE – SETUP GUIDE
==============================

FILES (keep together in one folder)
  index.html           public website
  admin.html           admin panel (password protected)
  config.js            your settings - the only file you edit
  supabase-setup.sql   database setup, run once
  assets/enteriva-product.jpeg   Enteriva image

HOW IT WORKS
  Admin adds/edits/deletes a product -> saved in Supabase (free database +
  image storage) -> the live website shows it for every visitor instantly.
  Inquiries go through Web3Forms straight to your email inbox.

STEP 1 - DATABASE (Supabase, free) ~10 minutes
  1. Go to supabase.com, sign up, click "New project" (pick any name/region,
     save the database password).
  2. When ready: SQL Editor > New query > paste all of supabase-setup.sql > Run.
  3. Project Settings > API: copy "Project URL" and the "anon public" key
     into config.js (supabaseUrl, supabaseAnonKey). The anon key is safe to publish.

STEP 2 - ADMIN LOGIN
  1. Supabase > Authentication > Users > Add user > Create new user.
     Enter your email + a strong password. Tick "Auto Confirm User".
  2. Supabase > Authentication > Sign In / Providers (or Settings):
     TURN OFF "Allow new users to sign up". (Important: otherwise anyone
     could create an account and edit products.)
  3. Open admin.html, sign in with that email/password.

STEP 3 - INQUIRY FORM (Web3Forms, free)
  1. Go to web3forms.com, enter the email where you want inquiries, get the
     Access Key by email. Paste it into config.js (web3formsKey).
  2. Optional: in the Web3Forms dashboard restrict the key to your website domain.
  Without a key the form falls back to opening the visitor's email app.

STEP 4 - WHATSAPP + OTHER PROFILES (optional, in config.js)
  whatsappNumber: digits with country code, e.g. 923001234567 (shows a
  WhatsApp button + link). extraLinks: add Facebook, YouTube, etc.
  Email, Instagram and LinkedIn are already filled in.

STEP 5 - PUBLISH
  Upload the whole folder (including assets) to Netlify Drop, Vercel,
  Cloudflare Pages or GitHub Pages. Visit /admin.html on your live site to
  manage products. Test locally first by opening index.html in Chrome.

NOTES
  - Images are resized automatically in the admin before upload.
  - Check all health-related wording against approved packaging and local
    regulations (e.g. DRAP) before adding or publishing product text.
  - If config.js is empty, the site shows only the built-in Enteriva
    product and admin shows a setup message.