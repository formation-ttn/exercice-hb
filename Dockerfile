# Déclaration des variables
# valeur modifiable à l'appel du build
ARG version=latest

FROM ubuntu:$version

# Deprecated use LABEL instead
#MAINTAINER JCD "jcd717@outlook.com"

LABEL maintainer="JCD <jcd717@outlook.com>" \
      description="test" \
      auteur="bruno dubois"

# Possibilité d'initialiser la cible avec des dossiers inexistant (créés à l'exécution de la commande)
# ADD fait la même chose que COPY mais si la source est zip/tar, désarchivage automatique
COPY heartbeat.sh /entrypoint.sh

# Eviter d'enchaîner plusieurs RUN 
# Raison : chaque étape avant "entrypoint" est mise en cache
RUN chmod +x /entrypoint.sh \
    && echo coucou > test.txt

ARG hbs=3
ENV HEARTBEATSTEP $hbs


# information de port réseau utile
# Ajoute une clé "ExposedPorts" dans le fichier .json du container
EXPOSE 1234/udp 4321/tcp

# Commande à exécuter au lancement du container
# Si pas d'entrypoint => valeur par défaut = /bin/sh -c
# TODO A ANALYSER : comment passer une variable à l'instruction CMD
# Surcharge possible au moment du docker run ex : docker run -it <image> --entrypoint bash
ENTRYPOINT ["/entrypoint.sh"]
# Arguments de l'entrypoint
CMD ["battement"]
