#!/bin/bash

# Caminho para o diretório onde será criada a nova página PHP
PAGE_DIR="/var/www/wordpress"

# Nome do arquivo da nova página PHP
PAGE_FILE="sobre_mim.php"

# Caminho para a imagem
IMAGE_PATH="images/minha_foto.jpg"

# Cria o diretório, se ele não existir, com permissões adequadas
# mkdir -p $PAGE_DIR
# chmod 755 $PAGE_DIR

# Cria ou modifica o arquivo PHP com o conteúdo desejado
cat <<EOF > $PAGE_DIR/$PAGE_FILE
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Mim</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }
        header {
            background: #333;
            color: #fff;
            padding-top: 30px;
            min-height: 70px;
            border-bottom: #77c7c4 3px solid;
        }
        header a {
            color: #fff;
            text-decoration: none;
            text-transform: uppercase;
            font-size: 16px;
        }
        #main-content {
            margin: 20px 0;
        }
        .profile-pic {
            max-width: 150px;
            border-radius: 50%;
        }
        .about {
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <h1>About me ...</h1>
        </div>
    </header>
    <div class="container">
        <section id="main-content">
            <h2>Hello, I'm fde-carv</h2>
            <img src="$IMAGE_PATH" alt="My Photo" class="profile-pic">
            <div class="about">
                <p>I'm a programming student and I'm learning Docker.</p>
                <p>I'm studding at 42 Porto and I love programming challenges.</p>
                <p>To learn more about me, visit my <a href="https://profile.intra.42.fr/" target="_blank">profile at 42</a>.</p>
            </div>
        </section>
    </div>
</body>
</html>
EOF

echo "$PAGE_FILE criado com sucesso in Docker."
