# Utiliser l'image Python 3.9 comme base pour le conteneur
FROM python:3.9

# S'assurer que le système est à jour
RUN apt-get update -y && apt-get upgrade -y

# Définir les variables d'environnement pour configurer Python
ENV PYTHONUNBUFFERED 1  
ENV PYTHONDONTWRITEBYTECODE 1 
ENV APP_HOME /invoice  
ENV XDG_RUNTIME_DIR /tmp/runtime-root  

# Créer le répertoire d'exécution et définir les permissions
RUN mkdir -p /tmp/runtime-root
RUN chmod -R 0700 /tmp/runtime-root 

# Créer le répertoire de l'application
RUN mkdir -p $APP_HOME
# Définir le répertoire de travail à l'intérieur du conteneur
WORKDIR $APP_HOME

# Installer les dépendances Python à partir du fichier requirements.txt
COPY requirements.txt $APP_HOME  
RUN python -m pip install --upgrade pip  
RUN pip install -r requirements.txt  

# Copier le code de l'application dans le répertoire de travail
COPY . $APP_HOME

# Définir les bonnes permissions pour le répertoire /tmp
RUN chmod -R 0700 /tmp  

