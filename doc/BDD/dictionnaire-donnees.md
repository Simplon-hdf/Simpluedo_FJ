## Dictionnaire de données pour Simpluedo

| Nom de la colonne  | Type         | Taille       | Description                                      |
|--------------------|--------------|--------------|--------------------------------------------------|
| `user_UUID`        | UUID         |              | Identifiant unique de l'utilisateur              |
| `pseudo`           | VARCHAR      |              | Pseudonyme de l'utilisateur                      |
| `roles`            | VARCHAR      |              | role attribué à l'utilisateur sur 1 partie       |
| `id_perso`         | INTEGER      |              | identifiant du personnage                        |
| `nom_perso`        | VARCHAR      |              | nom du personnage                                |
| `couleur_perso`    | VARCHAR      |              | couleur du personnage                            |
| `image_perso`      | VARCHAR      |              | image du personnage                              |
| `description_perso`| VARCHAR      |              | description du personnage                        |
| `id_salle`         | INTEGER      |              | identifiant de la salle                          |
| `nom_salle`        | VARCHAR      |              | nom de la salle                                  |
| `image_salle`      | VARCHAR      |              | image de la salle                                |
| `description_salle`| VARCHAR      |              | description de la salle                          |
| `id_objet`         | INTEGER      |              | identifiant de l'objet                           |
| `nom_objet`        | VARCHAR      |              | nom de l'objet                                   |
| `description_objet`| VARCHAR      |              | description de l'objet                           |
| `image_objet`      | VARCHAR      |              | image de l'objet                                 |
| `heure_arrive`     | TIME         |              | heure arrivé d'un personnage dans une salle      |
| `heure_sortie`     | TIME         |              | heure de sortie d'un personnage dans une salle   |