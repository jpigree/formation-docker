# Exposer un port et persister les données
## Objectifs
À l’issue de ces travaux pratiques, vous serez capable:
- d'exposer un port de conteneur sur l'hôte
- de persister des données dans un volume

---

## TP 1 – Exposer un port et persister les données

### Objectif
Lancer un Nginx avec le port 80 et le fichier index.html accessibles depuis l'hôte.

### Étapes

#### 1. Lancer un conteneur Nginx (mainline) avec son port 80 exposé sur le port 3333 de l'hôte 
<details>
<summary>Solution</summary>

```bash
# On expose Nginx sur le port 3333 car il n'est pas protégé comme le port 80.
docker run --rm -p 3333:80 --name nginx nginx:mainline    
```

</details>


#### 2. Rajouter un montage pour monter le répertoire contenant le fichier index.html sur "/tmp/data/nginx" sur l'hôte
Pour ce faire, il faut analyser le conteneur ou lire la documentation sur Dockerhub pour trouver le répertoire où se trouve le fichier `index.html`.

<details>
<summary>Solution</summary>

```bash
docker run --rm -p 3333:80 --name nginx --volume /tmp/data/nginx:/usr/share/nginx/html nginx:mainline
```

</details>


#### 3. Accéder au conteneur Nginx
Via curl ou directement avec un navigateur web.
```bash
# Sur l'hôte
curl http://127.0.0.1:3333
```

#### 4. Modifier le fichier index.html et vérifier que le changement est bien pris en compte
Remplacer le contenu du fichier "index.html" par "Je suis modifiable!".
Vérifier par curl ou un navigateur que la page a bien été modifiée.
compte Remplacer le contenu du fichier "index.html" par "Je suis modifiable!". Vérifier par curl ou un navigateur que la page a bien été modifiée.

<details>
<summary>Solution</summary>

```bash
echo "Je suis modifiable!" > /tmp/data/nginx/index.html
# Sur l'hôte
curl http://127.0.0.1:3333
```

</details>

## Nettoyage
- Nettoyer
```shell
# Arrêter le conteneur Nginx
# Il devrait s'auto-supprimer tout seul, sinon...
docker system prune
```

### À observer
- Le port de mon conteneur est accéssible depuis l'hôte
- Le contenu du répertoire monté est modifiable depuis l'hôte

---

## TP 2 – Lancer une base Postgres

### Objectif
Lancer une base de données Postgres en passant la configuration par les variables d'environnement prévues.

### Étapes

#### 1. Lancer un conteneur Postgres
Lancer un conteneur en mode détaché postgres en version 16 avec la configuration suivante:
- nom du conteneur: "postgres"
- utilisateur principal: "formation"
- mot de passe: "-formation-"
- base de données: "formation"
- Port exposé sur l'hôte: 5432
- Montage de la base de données dans le répertoire "db" dans le répertoire courant

Vous pouvez vous servir de la documentation de l'image officielle sur Dockerhub.
=> https://hub.docker.com/_/postgres

<details>
<summary>Solution</summary>

```bash
docker run --name postgres -e POSTGRES_PASSWORD=-formation- -e POSTGRES_USER=formation -e POSTGRES_DB=formation -p 5432 -v ./db:/var/lib/postgresql -d postgres:16
```

</details>


#### 2. Tester le conteneur
```bash
# Test de la configuration dans le conteneur
docker exec -it postgres psql --host=127.0.0.1  -p 5432 -U formation -d formation
# Test du port sur l'hôte

## Nettoyage
- Nettoyer
```shell
# Arrêter le conteneur Nginx
# Il devrait s'auto-supprimer tout seul, sinon...
docker system prune
```

### À observer
- Le port de mon conteneur est accéssible depuis l'hôte
- Le contenu du répertoire monté est modifiable depuis l'hôte

# Conclusion
C'est fini!!! Bravo!!!
