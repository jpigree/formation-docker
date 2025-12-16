# Orchestrer une application
## Objectifs
Le but de ce TP est d'orchestrer plusieurs conteneurs en utilisant Docker Compose.

---

## TP 1 – Orchestrer une application

### Objectif
Créer un fichier compose pour une application et son cache `redis`.


### Étapes

#### 1. Analyser l'application à orchestrer 
Une application est disponible dans le répertoire `formation-docker/orchestration/orchestrer-une-application/app`.

Il consiste en une application Python et un cache redis. Le Dockerfile est déjà écrit dans le répertoire app.

#### 2. Créer le fichier compose
Composé de 2 services:
- app
Le service app doit être construit a partir du Dockerfile. Le port de l'appli est `8000` mais doit être exposé sur le port `5000` de l'hôte.
- redis
Le conteneur redis doit utilisé l'image `redis:alpine`.

<details>
<summary>Solution</summary>
```yaml
services:
  web:
    build: .
    ports:
      - "8000:5000"
  redis:
    image: "redis:alpine"
```
</details>


#### 3. Démarrer votre pile logicielle
```bash
cd orchestrer-une-application
docker compose up
```

#### 4. Tester l'application déployée
```bash
curl http://localhost:8000/ 
```

## Nettoyage
- Nettoyer
```bash
cd orchestrer-une-application
docker compose down -v
```

### À observer
- J'arrive a déployer une application multi-containers en une commande.
- Je peux partager les informations de déploiement via un fichier yaml.

# Conclusion
C'est fini!!! Bravo!!!