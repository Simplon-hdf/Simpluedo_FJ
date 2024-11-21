## Dictionnaire de données pour Simpluedo

| Nom de la colonne    | Type         | Taille       | Description                                      |
|----------------------|--------------|--------------|--------------------------------------------------|
| `uuid_utilisateurs`  | UUID         |              | Identifiant unique de l'utilisateur              |
| `pseudo_utilisateurs`| VARCHAR      |              | Pseudonyme de l'utilisateur                      |
| `id_roles`           | INTEGER      |              | role attribué à l'utilisateur sur une partie     |
| `nom_roles`          | VARCHAR      |              | role attribué à l'utilisateur sur une partie     |
| `id_personnages`     | INTEGER      |              | identifiant du personnage                        |
| `nom_personnages`    | VARCHAR      |              | nom du personnage                                |
| `id_salles`          | INTEGER      |              | identifiant de la salle                          |
| `nom_salles`         | VARCHAR      |              | nom de la salle                                  |
| `id_objets`          | INTEGER      |              | identifiant de l'objet                           |
| `nom_objets`         | VARCHAR      |              | nom de l'objet                                   |
| `heure_arrivee`      | TIMESTAMPZ   |              | heure arrivé d'un personnage dans une salle      |
| `heure_sortie`       | TIMESTAMPZ   |              | heure de sortie d'un personnage dans une salle   |