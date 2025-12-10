# Premiers pas avec Docker
# Objectif
Installer l'outil Docker et se familiariser avec son usage.

# Etapes

## Installer Docker
Outil en ligne de commande: https://docs.docker.com/engine/install/

**IMPORTANT** *N'oublier pas de rajouter votre utilisateur dans le groupe "docker". Cela vous permettra de ne plus avoir a passer en root/sudo pour chaque commande Docker.*

Desktop: https://docs.docker.com/get-started/introduction/get-docker-desktop/


## Démarrer votre premier conteneur

- Lancer Nginx
```shell
$ docker run nginx --name mon-premier-nginx
```

- Vérifier son état
```shell
$ docker ps
# Utile pour de l'analyse de panne
$ docker inspect mon-premier-nginx
```

- Pour démarrer un conteneur Nginx, Docker a d'abord récupéré l'image depuis le registre Dockerhub
```shell
$ docker images --filter=reference=nginx --no-trunc  
```


- Il existe cependant d'autres registres (on peut notamment créer son propre registre privé)
```shell
$ docker pull quay.io/nginx/nginx-unprivileged
```


- Essayer d'ouvrir la page d'accueil de Nginx.

<details>
<summary>Solution</summary>

Le port n'est pas exposé sur l'hôte. Il n'est pas simple d'y accéder depuis l'hôte actuellement.

On verra comment faire dans la prochaine partie théorique.
</details>

- Lancer un shell dans le conteneur "mon-premier-nginx".
```shell
$ docker exec -it mon-premier-nginx bash
$ # Arrêter le shell (ctrl-c)
```

- Arrêter le conteneur.
```shell
$ docker stop mon-premier-nginx
```

## Registres et tags disponibles
- Trouver une image Postgres sur Dockerhub
    - https://hub.docker.com/


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

## Lancer un shell dans un conteneur
- Télécharger l'image ubuntu:26.04
<details>
<summary>Solution</summary>

```shell
$ docker pull ubuntu:26.04
```

</details>


- Créer le conteneur à partir de l'image. Il lancera un shell par défaut.
<details>
<summary>Solution</summary>

```shell
# L'image s'arrête immédiatement parce qu'elle lance un shell sans tty.
$ docker run ubuntu:26.04

# Pour lancer un conteneur intéractif avec tty
$ docker run -it ubuntu:26.04
```

</details>


- Créer un fichier "test" dans le conteneur à partir du shell précédent.
```shell
$ echo "test" > /test
```


- Noter l'id du conteneur puis arrêter le (ctrl-c dans le shell ou via docker stop)
```shell
$ UBUNTU_CONTAINER_ID="$(docker ps --filter=ancestor=ubuntu:26.04 -qa | head -n 1)"
# docker stop = SIGTERM
$ docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker stop
# docker stop = SIGKILL
$ docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker kill
```


- Afficher les conteneurs arrếtés
```shell
$ docker ps -a
```


- Créer un nouveau conteneur à partir de la même image. Le fichier existe t'il toujours? 
<details>
<summary>Solution</summary>
Non, car la commande "docker run" a crée un nouveau conteneur.
Pour retrouver le fichier "test", il faut relancer le conteneur précédent.

```shell
$ docker run -it ubuntu:26.04
$ cat /test
cat: /test: No such file or directory (os error 2)
```


Pour retrouver le fichier, il faut relancer le conteneur précédent:
```shell
$ docker start "$UBUNTU_CONTAINER_ID"
$ cat /test
test
```

**!!!IMPORTANT!!!** *Il est vivement déconseillé de stocker des fichiers persistants dans des conteneurs. Utiliser plutôt des montages de volumes.*
</details>

## Nettoyage
- Arrêter le conteneur précédent et nettoyer.
```shell
$ docker ps --filter=ancestor=ubuntu:26.04 -q | xargs -r docker stop
$ docker system prune
```

# Conclusion
C'est fini!!! Bravo!!!