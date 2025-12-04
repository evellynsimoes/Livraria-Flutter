# 1 - Preparar o projeto Flutter para publicação
1.1 - Verifique se o Flutter está funcionando
flutter doctor

# 2 - Configurar informações do app
2.1 - Ajustar o arquivo pubspec.yaml

Altere o nome, descrição e versão:

name: meu_app
description: Meu aplicativo Flutter
version: 1.0.0+1


1.0.0 → versão visível ao usuário

+1 → versão interna do Android

# 3 - Configurar a versão mínima do Android

Abra o arquivo:

android/app/build.gradle


Encontre:

defaultConfig {
    minSdk = 21
}

# 4 - Criar a chave de assinatura (keystore)

No terminal, dentro do projeto:

keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload


Será gerado:

android/app/my-release-key.jks

# 5 - Criar o arquivo key.properties

No diretório android/, crie o arquivo:

android/key.properties


Com o conteúdo:

storePassword=SUA_SENHA
keyPassword=SUA_SENHA
keyAlias=upload
storeFile=app/my-release-key.jks

# 6 - Configurar assinatura no Gradle

Abra:

android/app/build.gradle


Adicione dentro de android {}:

signingConfigs {
    release {
        storeFile file("../app/my-release-key.jks")
        storePassword keystoreProperties["storePassword"]
        keyPassword keystoreProperties["keyPassword"]
        keyAlias keystoreProperties["keyAlias"]
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled false
        shrinkResources false
    }
}

# 7 - Gerar o arquivo AAB (obrigatório pela Play Store)

Rode:

flutter build appbundle --release


O arquivo será criado em:

build/app/outputs/bundle/release/app-release.aab

# 8 - Criar a conta no Google Play Console

Acesse:

👉 https://play.google.com/console

Pague a taxa única de US$ 25

Aguarde a ativação da conta

# 9 - Criar um novo aplicativo na Play Store

Clique em Criar App

Preencha:

Nome do app

Idioma padrão

App ou Jogo

Grátis ou Pago

Aceite as políticas

# 10 - Preencher informações obrigatórias
10.1 - Configuração inicial

Público-alvo

Conteúdo sensível

Políticas obrigatórias

Segurança dos dados

10.2 - Classificação indicativa

Responda o questionário e gere a nota.

10.3 - Política de Privacidade

Hospede no GitHub Pages, Netlify, Firebase ou outro

# 11 - Preparar a Ficha da Loja (Store Listing)

Vá em:
Loja → Presença na loja → Ficha da loja

Preencha:

11.1 - Textos

Nome do app

Descrição curta

Descrição longa

11.2 - Imagens obrigatórias

Ícone 512 × 512

Screenshots:

Pelo menos 2 do celular

(Opcional) Tablet

11.3 - Banner opcional

1024 × 500 px

# 12 - Enviar o arquivo AAB

Vá em:
Lançamentos → Produção → Criar novo lançamento

Faça upload do arquivo app-release.aab

Escreva as notas da versão

# 13 - Revisar o lançamento

Clique em:

Revisar

Enviar para revisão

A Google irá analisar o app.

# 14 - Aguardar aprovação

O processo leva:

24h a 7 dias (média: 1–2 dias)

Após aprovação, o app aparece na Play Store.

# 15 - Atualizar o app futuramente
15.1 - Aumentar a versão

No pubspec.yaml:

version: 1.0.1+2

15.2 - Gerar novo AAB
flutter build appbundle --release

15.3 - Subir novamente em
Lançamentos → Produção → Novo lançamento
