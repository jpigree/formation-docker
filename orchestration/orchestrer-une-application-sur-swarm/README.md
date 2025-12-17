# Orchestrer une application
## Objectifs
Le but de ce TP est d'orchestrer plusieurs conteneurs en utilisant Docker Swarm.

---

## TP 1 – Orchestrer une application

### Objectif
Reprendre le fichier compose de l'exercice "orchestrer-une-application" et le rendre compatible Swarm.
### Étapes

#### 1. Construire l'image "app" en la nommant "swarm-app:1.0"
La construction des images de compose n'est pas compatible avec Swarm.
```bash
cd orchestrer-une-application-sur-swarm/app
docker build . -t swarm-app:1.0
```

#### 2. Remplacer le champ "build" de l'app par "image"
En utilisant l'image que vous avez généré précédemment.
```

```

#### 2. Rajouter le champ "deploy"
Le champ `deploy` est spécifique Swarm. Rajoutez le pavé de code suivant sur chacuns des services.

```bash
    deploy:
      # Mode global = conteneur déployé sur tout les noeuds
      # More replicated = Le nombre dans le champ replicas sera déployé et réparti sur les noeuds
      mode: replicated
      replicas: 1
      # Défini les ressources de l'application
      ressources:
        cpu: 0.5
        memory: 128Mi
```

#### 3. Initialiser votre Swarm
Pour que votre machine puisse être un Swarm, il faut l'initialiser.
```bash
docker swarm init
# Si vous avez bien 1 noeud, vous avez bien crée votre cluster Swarm
docker node ls
```


#### 3. Démarrer votre pile logicielle
```bash
cd orchestrer-une-application-sur-swarm
docker stack deploy -c ./compose.yaml app
```

#### 4. Tester l'application déployée
```bash
curl http://localhost:8000/
```

## Nettoyage
- Nettoyer
```bash
cd orchestrer-une-application
docker stack rm -f app
```

### À observer
- J'arrive a déployer une application multi-containers en une commande.
- Je peux partager les informations de déploiement via un fichier yaml.

# Conclusion
C'est fini!!! Bravo!!!