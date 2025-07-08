-- Catégories alimentaires
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
    unite_base VARCHAR(20) NOT NULL, -- kg, L, pièces, etc.
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

-- Lignes d'achat (détail des produits par facture)
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

-- Index pour optimiser les requêtes
CREATE INDEX idx_achats_date ON achats(date_achat);
CREATE INDEX idx_achats_fournisseur ON achats(fournisseur_id);
CREATE INDEX idx_lignes_achat_produit ON lignes_achat(produit_id);
CREATE INDEX idx_historique_prix_produit_date ON historique_prix(produit_id, date);

-- Insertion des catégories alimentaires françaises
INSERT INTO categories_alimentaires (nom, description) VALUES
('Fruits et légumes', 'Fruits frais, légumes, légumineuses'),
('Produits laitiers', 'Lait, fromages, yaourts, crème'),
('Féculents et céréales', 'Céréales, pommes de terre, légumes secs'),
('Viandes, poissons, œufs', 'Viandes, volailles, poissons, œufs'),
('Matières grasses', 'Huiles, beurre, margarines'),
('Produits sucrés', 'Sucre, confiseries, pâtisseries'),
('Boissons', 'Boissons non alcoolisées et alcoolisées'),
('Épices et condiments', 'Épices, herbes, sauces, condiments'),
('Produits surgelés', 'Produits congelés et surgelés');