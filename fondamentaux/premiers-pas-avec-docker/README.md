# Premiers pas avec Docker
## Objectifs
Installer l'outil Docker et se familiariser avec son utilisation.

---

## TP 1 – Installer Docker

### Objectif
Installer Docker sur votre poste.

### Étapes

#### 1. Installer Docker
Outil en ligne de commande: https://docs.docker.com/engine/install/

**IMPORTANT** *N'oublier pas de rajouter votre utilisateur dans le groupe "docker". Cela vous permettra de ne plus avoir a passer en root/sudo pour chaque commande Docker.*

Desktop: https://docs.docker.com/get-started/introduction/get-docker-desktop/

#### 2. Rajouter votre utilisateur au groupe "docker"
```bash
# Permet d'utiliser Docker sans passer par sudo
# Effectif qu'après s'être déconnecté puis reconnecté a votre compte
sudo usermod $USER -aG docker 
# Utiliser newgrp pour le rendre effectif dans votre shell local sans vous déconnecter
newgrp docker
```

#### 4. Lancer votre premier conteneur
```bash
docker run helloworld --name helloworld
```

#### 5. Vérifier l'état du conteneur
```bash
$ docker ps -a
# Utile pour de l'analyse de panne
$ docker inspect helloworld
```

### À observer
- Le conteneur s’exécute puis s’arrête immédiatement
- Le message s’affiche dans la sortie standard
- Le conteneur est arrêté

---

## TP 2 – Manipuler un conteneur

### Objectif
Se familiariser avec Docker.

#### 1 Démarrer un conteneur Nginx
```bash
docker run nginx:latest --name mon-nginx
```

#### 2 Inspecter le conteneur crée
Pour démarrer un conteneur Nginx, Docker a d'abord récupéré l'image depuis le registre Dockerhub

```bash
docker images --filter=reference=nginx --no-trunc  
```

#### 3 Récupérer une image depuis un registre différent
Il existe cependant d'autres registres (on peut notamment créer son propre registre privé)
```bash
docker pull quay.io/nginx/nginx-unprivileged
```

#### 4 Essayer d'ouvrir la page d'accueil de Nginx
<details>
<summary>Solution</summary>

Le port n'est pas exposé sur l'hôte. Il n'est pas simple d'y accéder depuis l'hôte actuellement.

On verra comment faire dans la prochaine partie théorique.
</details>

Lancer un shell dans le conteneur "mon-nginx".
```bash
docker exec -it mon-nginx bash
# Arrêter le shell (ctrl-c)
```

#### 5 Supprimer le conteneur
```bash
docker stop mon-nginx
```

### À observer
- Docker a récupérer l'image avant de déployer le conteneur
- Le conteneur arrếté n'est pas supprimé

---

## TP 3 – Exercices un peu plus poussés

#### 1 Trouver une image Postgres sur Dockerhub
Lien: https://hub.docker.com/

**!!!IMPORTANT!!!**
*Privilégier les images officielles (vérifier le badge et le mainteneur). Des images vérolées existent sur les dépôts publics.*

- Il existe plusieurs versions officielles:
    - https://hub.docker.com/_/postgres
    - La plupart des projets opensource publient des images sur des distributions différentes:
        - postgres:18-bookworm (postgres sur debian bookworm)
        - postgres:alpine (postgres sur alpine, un OS minimaliste)
    - Egalement, les projets proposent des tags versions différents:
        - 18, un tag qui correspond a la dernière version 18 publiée (patch le plus récent). A chaque publication d'un nouveau patch, cette image est écrasée par la plus récente.
        - 18.1, un tag fixe qui correspond a la version 18.1.

*Prendre le temps de lire la page sur Dockerhub décrivant comment utiliser les images.*

#### 2 Télécharger l'image ubuntu:26.04
Télécharger l'image ubuntu:26.04
<details>
<summary>Solution</summary>

```shell
docker pull ubuntu:26.04
```

</details>

#### 3 Créer un un shell dans un conteneur
- Créer le conteneur à partir de l'image. Il lancera un shell par défaut.
<details>
<summary>Solution</summary>

```shell
# L'image s'arrête immédiatement parce qu'elle lance un shell non intéractif sans tty.
docker run ubuntu:26.04

# Pour lancer un conteneur intéractif avec tty
docker run -it ubuntu:26.04
```

</details>

#### 4 Créer un fichier "test" dans le conteneur à partir du shell précédent.
```shell
$ echo "test" > /test
```

#### 5 Arrêter le shell
Noter l'id du conteneur puis arrêter le (ctrl-c dans le shell ou via docker stop)
```bash
UBUNTU_CONTAINER_ID="$(docker ps --filter=ancestor=ubuntu:26.04 -qa | head -n 1)"
# docker stop = SIGTERM
docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker stop
# docker stop = SIGKILL
docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker kill
```

Afficher les conteneurs arrếtés
```shell
$ docker ps -a
```

#### 5 Créer un nouveau conteneur à partir de la même image. Le fichier existe t'il toujours? 
<details>
<summary>Solution</summary>
Non, car la commande "docker run" a crée un nouveau conteneur.
Pour retrouver le fichier "test", il faut relancer le conteneur précédent.

```bash
$ docker run -it ubuntu:26.04
$ cat /test
cat: /test: No such file or directory (os error 2)
```

Pour retrouver le fichier, il faut relancer le conteneur précédent:
```bash
$ docker start "$UBUNTU_CONTAINER_ID"
$ cat /test
test
```

**!!!IMPORTANT!!!** *Il est vivement déconseillé de stocker des fichiers persistants dans des conteneurs. Utiliser plutôt des montages de volumes.*
</details>

#### 6 Nettoyer
- Arrêter le conteneur précédent et nettoyer.
```bash
docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker stop
docker system prune
```
### À observer
- Les conteneurs arrếtés peuvent être relancés via `docker start`
- `docker run` crée un nouveau conteneur a chaque fois
- Les fichiers contenus dans les conteneurs hors montage sont considérés comme éphémères.

# Conclusion
C'est fini!!! Bravo!!!