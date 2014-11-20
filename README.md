Simplonline
==========

## Plateforme Formation Ouverte à distance de Simplon.co

### Principe

* Les élèves en présentiel rédigent des contenus représentant le meilleur de ce qu'ils ont appris dans la semaine.
* Les éléves en présentiel définissent des exercices lors de la restitution du vendredi.
* Les élèves à distance peuvent accéder aux cours et aux exercices.

## Développement / Déploiement

Pour démarrer l'application complète :

`foreman start web`

Il y a une partie web et un worker qui sert pour la vérification d'exercice. En production les deux seront sûrement séparé.

### Installation

Pré-requis :

- Avoir installé Rails

`sudo gem install rails --no-ri --no-rdoc`

Dans rbenv, être en environnement ruby 2.1.2

Commandes utiles

```
    rbenv versions  
    rbenv install 2.1.2
    rbenv global 2.1.2
    rbenv rehash

Avoir installé PostgreSQL

`sudo apt-get install postgresql`

Avoir installé Redis

`sudo apt-get install redis-server`

Ensuite, récupérer les fichiers source sur Github :

`git clone https://github.com/simplonco/simplonline`

Renommer le fichier `dotenv` en fichier `.env` :

`cp dotenv .env`

Fermer puis rouvrir le Terminal.

Entrer dans le dossier simplonline.

Configurer le compte utilisateur dans PostgreSQL :

`sudo su postgres`

puis 

`psql`

puis 

`create role sensei with createdb login password 'something';`

Pour vérifier que le changement est OK :

`\dgh`

Pour voir l’aide de Postgres :  ```\?```

Pour sortir de la console PSQL et revenir à la ligne de commande du terminal ```Ctrl  D``` (deux fois !). 

Puis installer les gems nécessaires :

```
gem install bundler
bundle install 
```

Si `error pg`   ------>    `sudo apt-get install libpq-dev`         

Puis configurer la base de données :

```
rake  db:create
rake  db:migrate
rake  db:seed
```

Pour lancer le site de test en local (localhost port 3000):

`foreman start web`


## Production

Pour le moment, nous déployons sur http://foad.simplon.co 
