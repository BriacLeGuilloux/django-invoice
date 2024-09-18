# Utiliser l'image Python 3.9 comme base pour le conteneur
FROM python:3.9

# S'assurer que le système est à jour
RUN apt-get update -y && apt-get upgrade -y

# Définir les variables d'environnement pour configurer Python
ENV PYTHONUNBUFFERED 1  # Désactive la mise en tampon de la sortie Python (utile pour les logs en temps réel)
ENV PYTHONDONTWRITEBYTECODE 1  # Empêche Python de créer des fichiers .pyc (fichiers bytecode)
ENV APP_HOME /django-invoice  # Définir le répertoire de l'application
ENV XDG_RUNTIME_DIR /tmp/runtime-root  # Définir le répertoire d'exécution temporaire

# Créer le répertoire d'exécution et définir les permissions
RUN mkdir -p /tmp/runtime-root
RUN chmod -R 0700 /tmp/runtime-root  # Accorder les droits complets au propriétaire

# Créer le répertoire de l'application
RUN mkdir -p $APP_HOME
# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR $APP_HOME

# Installer les dépendances Python à partir du fichier requirements.txt
COPY requirements.txt $APP_HOME  # Copier le fichier requirements.txt dans le répertoire de l'application
RUN python -m pip install --upgrade pip  # Mettre à jour pip (le gestionnaire de paquets Python)
RUN pip install -r requirements.txt  # Installer les paquets requis listés dans requirements.txt

# Copier le code de l'application dans le répertoire de travail
COPY . $APP_HOME

# Définir les bonnes permissions pour le répertoire /tmp
RUN chmod -R 0700 /tmp  # Accorder les droits complets au propriétaire pour le répertoire temporaire

