# Créer mes premières images
## Objectifs
À l’issue de ces travaux pratiques, vous serez capable de :
- écrire un Dockerfile simple
- construire une image Docker
- lancer et tester un conteneur
- comprendre l’impact du Dockerfile sur le comportement du conteneur
- identifier des erreurs courantes liées aux Dockerfiles

---

## TP 1 – Créer une image Docker

### Objectif
Créer une image Docker minimale et comprendre la relation entre Dockerfile, image et conteneur.

### Étapes

#### 1. Clôner le dépôt.

```bash
git clone https://github.com/jpigree/formation-docker
cd formation-docker
```

#### 2. Consulter le Dockerfile suivant.
Lire le Dockerfile se trouvant dans `formation-docker/fondamentaux/créer-mes-premières-images/simple-exemple`. 

#### 3. Construire l’image

```bash
cd simple-exemple
docker build -t hello-docker .
```

#### 4. Lancer un conteneur à partir de l'image
```bash
# --rm supprime le conteneur automatiquement dès qu'il se termine
docker run --rm hello-docker
```

### À observer
- Le conteneur s’exécute puis s’arrête immédiatement
- Le message s’affiche dans la sortie standard

---

## TP 2 – Créer une image pour une application existante

### Objectif
Créer une image Docker pour une application réelle puis l'utiliser.

### Étapes

#### 1. Analyser l’application
L'application se trouve dans `formation-docker/fondamentaux/créer-mes-premières-images/docker-helloworld`. Identifier en lisant son README.md:
- comment installer l'application
- sur quel port elle écoute
- comment la lancer

#### 2. Créer le Dockerfile
Créer le Dockerfile qui permet de lancer cette application dans un conteneur.

#### 3. Construire l’image
```bash
docker build -t docker-helloworld .
```

#### 4. Lancer le conteneur
```bash
docker run --name helloworld docker-helloworld
```

#### 5. Tester l’application
```bash
docker exec -it helloworld curl http://localhost:5000
docker logs -f helloworld
```

#### 6. Arrêter l'application
```bash
docker stop helloworld
```

### Points à retenir
- EXPOSE est uniquement informatif
- docker logs affiche le contenu de la stdout et stderr de la commande lancée.

---

## TP 3 – Problème de PID 1

### Objectif
Mettre en évidence le problème du PID 1.

### Étapes

#### 1. Consulter un Dockerfile problématique
Consulter le Dockerfile situé dans `formation-docker/fondamentaux/créer-mes-premières-images/pid1`.

#### 2. Construire l’image associée
```bash
cd pid1
docker build -t bash:pid1 .
```

#### 3. Lancer un conteneur
```bash
docker run --name bash-test bash:pid1
```

#### 4. Arrêter le conteneur depuis un autre terminal
```bash
# docker stop envoie un SIGTERM a bash
# Le signal n'est pas propagé a sleep qui ne s'arrête pas
# Au bout de 10 secondes, docker stop envoie un SIGKILL
docker stop bash-test
```

### À observer
- Arrêt lent
- Mauvaise gestion des signaux

#### 5. Refaire les étapes 3. et 4. en utilisant l'option "--init" lors du "docker run"

#### 6. Corriger le problème dans le Dockerfile et retester
Dans le Dockerfile, corriger l'entrypoint pour lancer directement la commande `sleep` sans `bash`.
Puis, refaire les étapes 2,3 et 4.

---

## Nettoyage
- Nettoyer
```shell
$ docker system prune -a
```

# Conclusion
C'est fini!!! Bravo!!!