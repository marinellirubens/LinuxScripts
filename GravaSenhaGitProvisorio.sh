# comando para que o git memorize a senha e usuario por um tempo igual ao sudo
git config --global credential.helper cache

# comando para que o tempo que o git memorize fique em 1 hora em vez de 15 minutos que é o padrao.
git config --global credential.helper 'cache --timeout=3600'
