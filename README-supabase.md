# Supabase Database Setup

## Local Development

### Start Local Supabase
```bash
supabase start
```

This will start:
- PostgreSQL database on port 54322
- Supabase Studio on http://localhost:54323
- API Gateway on http://localhost:54321

### Switch to Local Database
In `.env.local`, comment out production and uncomment local:
```env
# Production
# VITE_SUPABASE_URL=https://kteojbfsmxtponbwabtz.supabase.co
# VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Local Development
VITE_SUPABASE_URL=http://localhost:54321
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### Apply Migrations
```bash
supabase db reset
```

### Stop Local Supabase
```bash
supabase stop
```

## Migration Management

### Create New Migration
```bash
supabase migration new migration_name
```

### Apply Migrations to Production
```bash
supabase db push
```

### Pull Schema from Production
```bash
supabase db pull
```

## Database Schema

### Tables Created
- `categories_alimentaires` - French food categories
- `fournisseurs` - Suppliers
- `produits_alimentaires` - Food products
- `achats` - Purchases/invoices
- `lignes_achat` - Purchase line items
- `historique_prix` - Price history

### Initial Data
9 French food categories are pre-populated:
- Fruits et légumes
- Produits laitiers
- Féculents et céréales
- Viandes, poissons, œufs
- Matières grasses
- Produits sucrés
- Boissons
- Épices et condiments
- Produits surgelés