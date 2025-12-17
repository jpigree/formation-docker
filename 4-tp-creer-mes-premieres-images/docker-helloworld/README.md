# Docker hello-world

Cette application écoute sur 2 chemins HTTP:
- '/' qui display un message "Hello World!" avec le nom du conteneur
    d'où il est lancé
- '/health' qui est un healthcheck basique

# Installation

Pour installer cette application, il faut:
- Installer **Python 3.5**.
- Installer ses dépendances:
```bash
pip install -r ./requirements.txt
```
- La lancer
```
python ./app.py
```
Par défaut, l'application écoute sur le port *5000*.
