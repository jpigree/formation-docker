# Démonstration

## Objectif
Démontrer l'intérêt de la conteneurisation Docker.

## Etapes

#### 1. Lancer l'application d'exemple

```bash
cd spring-postgres
docker compose up -d
```

#### 2. Vérifier que tout les services sont bien lancés
```bash
docker stats
```

#### 3. Tester l'application lancée

```bash
curl http://127.0.0.1:8080
```

#### 4. Supprimer l'application lancée

```bash
docker compose down -v
```
