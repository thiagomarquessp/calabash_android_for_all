# Cavala Calava Calaba Calabash (Montando o ambiente de trabalho).

Bem, antes de mais nada estou trabalhando em um MAC, mas isso não é um problema para quem ta trabalhando com Windows ou Linux. O princípio vai ser o mesmo, mas, caso você seja um QA da velha escola, que tal aprender um outro Sistema Operacional??? Então pra deixar claro, usando o Windows vc vai ter que usar o dobro o stackoverflow, principalmente no quesito montagem de ambiente. Montar ambiente para testes usando Ruby por exemplo no Mac é um porre danado, mas depois de muito trabalho, você consegue.

Vamos lá. Em meu ambiente de trabalho eu vou precisar da seguinte receita:

```ruby
a. Computador: OK;
b. Java instalado:
   Mac: https://java.com/en/download/help/mac_install.xml;
   Win: https://java.com/en/download/;
   Linux: https://www.java.com/pt_BR/download/help/linux_x64_install.xml;
c. Java Development Kit (JDK): http://www.oracle.com/technetwork/pt/java/javase/downloads/index.html;
d. Android Studio: https://developer.android.com/studio/install.html;
e. Assim que instalar o Android, instalar os pacotes de SDK Platafform dele;
```

Esse é o princípio, mas não da pra fazer nada apenas com isso certo?? Vamos precisar instalar o ruby e claro, a gem do calabash-android:

Para instalar o ruby:

```ruby
Windows:

Necessário: rubyinstaller (http://rubyinstaller.org/downloads/).

Obs.: Quando se instala o ruby, será necessário a instalação do DevKit correspondente da versão que você instalou.

Mac ou Linux:

Necessário: Baixar o Xcode pelo link: https://developer.apple.com/xcode/downloads/. Aprendi que sempre que instalar o SO, a primeira coisa será instalar o Xcode.

Bem, depois do Xcode, vamos baixar o Homebrew via terminal com o comando:

ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)” .
```

Ruby instalado, vamos instalar duas gems: bundler e claro calabash-android:

```ruby
gem install bundler
gem install calabash-android
```

Depois de todo esse trampo (instlar Android Studio, SDKs, Java e JDK), agora temos que definir algumas variáveis de ambiente no nosso arquivo e bash_profile (MAC e Linux) ou nas variáveis de ambiente do Windows:

```ruby
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

Qualquer outra variável que estiver lá NÃO mexa Ok.

Importante saber que definir as variáveis de ambiente é o principal da configuração do ambiente. Sem isso nada funciona. Ok =)

Reinicie a máquina e bora pro documento III. =)
