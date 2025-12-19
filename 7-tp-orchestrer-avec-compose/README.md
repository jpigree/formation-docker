# Orchestrer une application
## Objectifs
Le but de ce TP est d'orchestrer plusieurs conteneurs en utilisant Docker Compose.

---

## TP 1 – Orchestrer une application

### Objectif
Créer un fichier compose pour une application Python et son cache `redis`.

### Étapes

#### 1. Clôner le dépôt.

```bash
git clone https://github.com/jpigree/formation-docker
cd formation-docker/7-tp-orchestrer-avec-compose
```

#### 2. Analyser l'application à orchestrer 
Une application est disponible dans le répertoire `app`.

Il consiste en une application Python et un cache redis. Le Dockerfile est déjà écrit dans le répertoire app.

#### 3. Créer le fichier compose
Composé de 2 services:
- app
Le service app doit être construit a partir du Dockerfile. Le port de l'appli est `8000` mais doit être exposé sur le port `5000` de l'hôte.
- redis
Le conteneur redis doit utilisé l'image `redis:alpine`.

<details>
<summary>Solution</summary>
```yaml
# formation-docker/orchestration/orchestrer-une-application/compose.yaml
services:
  web:
    build: ./app
    ports:
      - "8000:5000"
  redis:
    image: "redis:alpine"
```
</details>


#### 4. Démarrer votre pile logicielle
```bash
cd 7-tp-orchestrer-avec-compose
docker compose up
```

#### 5. Tester l'application déployée
```bash
curl http://localhost:8000/ 
```

## Nettoyage
- Nettoyer
```bash
cd 7-tp-orchestrer-avec-compose
docker compose down -v
```

### À observer
- J'arrive a déployer une application multi-containers en une commande.
- Je peux partager les informations de déploiement via un fichier yaml.

# Conclusion
C'est fini!!! Bravo!!!