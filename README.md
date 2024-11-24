# SIMPLUEDO

##  SOMMAIRE
 
- [1. BDD](doc/BDD)
    - [1.1 Dictionnaire de données](doc/BDD/dictionnaire-donnees.md)
    - [1.2 MCD](doc/BDD/mcd.png)
    - [1.3 MLD](doc/BDD/mld.png)
    - [1.4 MPD](doc/BDD/mpd.png)
    - [1.5 Script initialiation](doc/BDD/script.sql)
    - [1.6 Script injection de données](doc/BDD/simpluedo-data.sql)
    - [1.7 Sauvegardes](doc/BDD/sauvegardes)

## Commande exportation de la database avec pg-dump

**Commande avec le chemin :**
```
pg_dump -h localhost -p 5432 -U justindidelot simpluedo > /Users/justindidelot/Documents/Sites/lab/simpluedo_victorious_maniacs/doc/BDD/sauvegardes/simpluedo_backup.sql  
```

**Commande sans le chemin :**
```
pg_dump -h localhost -p 5432 -U justindidelot simpluedo > simpluedo_backup.sql  
```
## Requêtes à réaliser

**- Lister tous les personnages du jeu :**

```sql
SELECT nom_personnages FROM personnages;
```

**- Lister chaque joueur et son personnage associé :**

```sql
SELECT pseudo_utilisateurs, nom_personnages FROM utilisateurs
INNER JOIN personnages ON personnages.id_personnages = utilisateurs.id_personnages;
```

**- Afficher la liste des personnages présents dans la cuisine entre 08:00 et 09:00 :**

```sql
SELECT nom_personnages FROM personnages
INNER JOIN visiter ON visiter.id_personnages = personnages.id_personnages
INNER JOIN salles ON salles.id_salles = visiter.id_salles
WHERE salles.nom_salles = 'Cuisine'
AND visiter.heure_arrivee BETWEEN '8:00' AND '9:00';
```

**- Afficher les pièces où aucun personnage n'est allé :**

```sql
SELECT nom_salles FROM salles 
WHERE salles.id_salles NOT IN (SELECT DISTINCT visiter.id_salles FROM visiter);
```

**- Compter le nombre d'objets par pièce :**

```sql
SELECT nom_salles, COUNT(id_objets) FROM salles 
LEFT JOIN objets ON salles.id_salles = objets.id_salles 
GROUP BY salles.nom_salles;
```

**- Ajouter une pièce :**

```sql
INSERT INTO salles (nom_salles) VALUES 
('Salle de musique');
```

**- Modifier un objet :**

```sql
UPDATE objets 
SET nom_objets = 'Batte de baseball' 
WHERE id_objets = 6;
```

**- Supprimer une pièce :**

```sql
DELETE FROM salles 
WHERE id_salles = 10;
```
