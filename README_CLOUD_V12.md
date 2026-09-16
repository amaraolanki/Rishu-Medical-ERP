# Rishu Medical & Healthcare ERP V12 — Cloud Sync

This version keeps the existing Marg-style ERP UI and adds optional Supabase cloud sync.

## Setup
1. Create a Supabase project.
2. Open SQL Editor and run `SUPABASE_SETUP.sql`.
3. In Supabase Project Settings/API Keys, copy the Project URL and Publishable Key.
4. Open the ERP → Settings / Cloud.
5. Enter Project URL, Publishable Key, Cloud Email and Password.
6. Use **Create Cloud Account** on the first device, then **Push Local** to upload the current data.
7. On another device, use the same Project URL, Publishable Key and cloud account → **Connect / Sign In** → **Pull Cloud**.
8. After connection, normal saves are automatically pushed after a short delay.

The frontend must use only the Supabase publishable key. Never put a service-role/secret key in the ERP.

Note: this version intentionally does not sync the old local `users` password list. Supabase Auth is the cloud authentication layer.
