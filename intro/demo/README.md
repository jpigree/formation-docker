# Démonstration

# Objectif
Démontrer l'intérêt de la conteneurisation Docker.

# Etapes

- Lancer l'application d'exemple

```sh
$ cd spring-postgres
$ docker compose up -d
```

- Vérifier que tout les services sont bien lancés
```sh
$ docker stats
```

- Tester l'application lancée

```sh
$ curl http://127.0.0.1:8080
```

- Supprimer l'application lancée

```sh
$ docker compose down -v
```
