-- Categories alimentaires
CREATE TABLE categories_alimentaires (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nom VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Fournisseurs
CREATE TABLE fournisseurs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    adresse TEXT,
    telephone VARCHAR(20),
    email VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Produits alimentaires
CREATE TABLE produits_alimentaires (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    nom VARCHAR(200) NOT NULL,
    categorie_id UUID REFERENCES categories_alimentaires(id),
    unite_base VARCHAR(20) NOT NULL, -- kg, L, pieces, etc.
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Achats (factures)
CREATE TABLE achats (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    fournisseur_id UUID REFERENCES fournisseurs(id),
    date_achat DATE NOT NULL,
    date_livraison DATE,
    numero_facture VARCHAR(100),
    montant_total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Lignes d'achat (detail des produits par facture)
CREATE TABLE lignes_achat (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    achat_id UUID REFERENCES achats(id) ON DELETE CASCADE,
    produit_id UUID REFERENCES produits_alimentaires(id),
    quantite DECIMAL(10,3) NOT NULL,
    unite VARCHAR(20) NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    prix_total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Historique des prix
CREATE TABLE historique_prix (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    produit_id UUID REFERENCES produits_alimentaires(id),
    fournisseur_id UUID REFERENCES fournisseurs(id),
    date DATE NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    quantite DECIMAL(10,3) NOT NULL,
    unite VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index pour optimiser les requetes
CREATE INDEX idx_achats_date ON achats(date_achat);
CREATE INDEX idx_achats_fournisseur ON achats(fournisseur_id);
CREATE INDEX idx_lignes_achat_produit ON lignes_achat(produit_id);
CREATE INDEX idx_historique_prix_produit_date ON historique_prix(produit_id, date);

-- Insertion des categories alimentaires francaises
INSERT INTO categories_alimentaires (nom, description) VALUES
('Fruits et legumes', 'Fruits frais, legumes, legumineuses'),
('Produits laitiers', 'Lait, fromages, yaourts, creme'),
('Feculents et cereales', 'Cereales, pommes de terre, legumes secs'),
('Viandes, poissons, oeufs', 'Viandes, volailles, poissons, oeufs'),
('Matieres grasses', 'Huiles, beurre, margarines'),
('Produits sucres', 'Sucre, confiseries, patisseries'),
('Boissons', 'Boissons non alcoolisees et alcoolisees'),
('Epices et condiments', 'Epices, herbes, sauces, condiments'),
('Produits surgeles', 'Produits congeles et surgeles');