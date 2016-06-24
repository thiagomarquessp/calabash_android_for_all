# Lidando com os elementos.

Após a configuração do ambiente, já podemos trabalhar em paz =), mas antes, no Android Studio, em SDK Manager instale os pacotes que você deseja trabalhar em Platafform Tools e Tools. Vou colocar os que eu estou utilizando ok?:

```ruby
SDK Platafforms: Androi 6.0 - Marshmallow;
SDK Tools:
  - Android SDK Build Tools;
  - Android Auto API Simulator;
  - Android SDK Platafform-Tools 24.0.0;
SDK Update Sites: Todos da lista.
```
Coloque o seu celular em modo Desenvolvedor e com Transferência de Fotos (PTP) e Depuração USB habilitada e coloque-o desbloqueado no seu computador.

Vamos no terminal, na pasta do Android Platafform-Tools e execute o seguinte comando: ./adb devices (se estiver no Windows, ./adb.exe devices) para conseguir enxergar o seu device e o resultado será esse:

```ruby
Biro-MacBook-Pro:platform-tools phoenix$ ./adb devices

List of devices attached
0017338702	device
```

Ótimo, vimos que estamos enxergando o nosso device, agora é só trabalhar.

No repositório, dentro da pasta cucumber temos uma apk que vamos utilizar para estudar, o nome dela é busca_cep, foi um fork que eu fiz de um rapaz, fiz uma suíte de testes funcional para ele (trabalho acadêmico) e ele liberou para eu utilizar. MAS ... caso você tenha qualquer aplicativo nativo (que é o nosso foco) em extensão .apk o conceito se aplica. Se na empresa que você trabalha tem um aplicativo nativo, e você quer aplicar os conceitos dentro de casa, pede pro Dev Android gerar uma versão para tu começar a brincar.

Navegue até a pasta cucumber e execute o seguinte comando:

```ruby
calabash-android resign busca_cep.apk

Esse comando serve para você assinar a versão e com isso criar o servidor de testes para conseguir rodar, buscar elementos, etc.
```

Depois do app estar assinado, vamos entrar em modo console para conseguirmos ver os elementos que esse aplicativo possui, e interagir com eles também. Nessa primeira versão do Calabash For All eu vou colocar o básico para que tu consiga sair do estágio negativo e chegar ao estágio zero. Será feito um segundo Calabash For All com boas práticas, tópicos avançados. Misturar tudo aqui vai confundir geral. Execute o seguinte comando:

```ruby
calabash-android console busca_cep.apk

Esse será o resultado:

Done signing the test server. Moved it to test_servers/fa76e313cc2907703902f9defd2f7867_0.7.3.apk
Starting calabash-android console...
Loading /Users/phoenix/.rvm/gems/ruby-2.2.0/gems/calabash-android-0.7.3/irbrc
Running irb...
irb(main):001:0>
```
Pronto, entramos no console do calabash. E agora, vamos brincar com nosso app. Segue abaixo os comandos legais =).

```ruby
irb(main):004:0> reinstall_apps
true
irb(main):005:0>

Usado para reinstalar o aplicativo no seu device. O resultado deve ser true (que quer dizer que apagou a ultima versão e instalou uma nova, se não tinha versão nenhuma, apenas instala).

Depois vamos entrar no aplicativo em modo console:

irb(main):005:0> start_test_server_in_background
nil
irb(main):006:0>

Esse comando entra no seu aplicativo em modo console (inclusive vc vai ver que ele abriu no seu device).
```

Bom ... agora que estamos no console do nosso aplicativo (ufa) vamos para alguns conceitos básicos com relação a gestos no Android e o melhor lugar é no próprio site: https://material.google.com/patterns/gestures.html#gestures-touch-mechanics. Se tu digitar por exemplo: touch, pinch open, rotate, double_tap, tap, etc. no console, vai ver que a lista vai aparecendo (basta auto completar com TAB).

Alguns comandos que não aparecem nos gestures seria a interação ser humano x teclado celular x app:

```ruby
enter_text - Para inserir textos;
keyboard_enter_text - Habilita para digitação o teclado do device;
```

Bem, direto ao ponto, vamos entender o seguinte: Os elementos do Android possuem uma classe padrão: "android.widget.XXX", onde XXX pode ser o tipo Button, EditText, etc.

Na prática, vamos lá:

```ruby
irb(main):010:0> query("android.widget.Button")
[
    [0] {
                     "class" => "android.support.v7.widget.AppCompatButton",
                       "tag" => nil,
               "description" => "android.support.v7.widget.AppCompatButton{c8b93f0 VFED..C.. ........ 32,445-688,565 #7f0c005f app:id/btnCep}",
                        "id" => "btnCep",
                      "text" => "BUSCAR CEP",
                   "visible" => true,
                      "rect" => {
              "height" => 120,
               "width" => 656,
                   "y" => 605,
                   "x" => 32,
            "center_x" => 360,
            "center_y" => 665
        },
                   "enabled" => true,
        "contentDescription" => nil
    },
    [1] {
                     "class" => "android.support.v7.widget.AppCompatButton",
                       "tag" => nil,
               "description" => "android.support.v7.widget.AppCompatButton{a214d69 VFED..C.. ........ 32,565-688,685 #7f0c0060 app:id/btnHistorico}",
                        "id" => "btnHistorico",
                      "text" => "HISTÓRICO",
                   "visible" => true,
                      "rect" => {
              "height" => 120,
               "width" => 656,
                   "y" => 725,
                   "x" => 32,
            "center_x" => 360,
            "center_y" => 785
        },
                   "enabled" => true,
        "contentDescription" => nil
    }
]
```

Olha que coisa linda esse resultado. Temos exatamente dois botões no App (BUSCA CEP e HISTÓRICO) na tela inicial. O resultado veio com o índice [0] ou [1] num Json com todo o elemento desmembrado (class, tag, description, id, text, visible, etc.). Bom, agora que sabemos e consultamos os elementos disponíveis nessa tela, vamos interagir e clicar no botão de Buscar CEP da seguinte forma:

```ruby
touch ("android.support.v7.widget.AppCompatButton")
```

Viram .. ele clicou no botão \o/ .... Até escorreu uma lágrima.

Agora vamos ver como inserir texto no campo de CEP:

```ruby
Primeiro temos que encontrar o elemento, que no caso é do tipo EditText:

  irb(main):022:0> query("android.widget.EditText")
  [
      [0] {
                       "class" => "android.support.v7.widget.AppCompatEditText",
                         "tag" => nil,
                 "description" => "android.support.v7.widget.AppCompatEditText{2170b29 VFED..CL. .F...... 0,0-660,101 #7f0c0050 app:id/edtCep}",
                          "id" => "edtCep",
                        "text" => "",
                     "visible" => true,
                        "rect" => {
                "height" => 101,
                 "width" => 660,
                     "y" => 190,
                     "x" => 30,
              "center_x" => 360,
              "center_y" => 240
          },
                     "enabled" => true,
          "contentDescription" => nil
      }
  ]

Agora temos que dar um touch nesse elemento para habilitar o teclado para conseguir pasar algum valor pra ele:

irb(main):023:0> touch ("android.support.v7.widget.AppCompatEditText")
nil

Habilitou o teclado como você viu no device e agora, é só passar o texto =)

irb(main):048:0> keyboard_enter_text("05433001")
{
    "bonusInformation" => [],
             "message" => "",
             "success" => true
}

Pufffff ... igual mágica passamos um texto só via linha de comando \o/.

Mas calma, vamos clicar no botão neh para pesquisar o CEP:

Primeiro, vamos dar um Hide no teclado, para evitar qualquer problemas:

irb(main):051:0> hide_soft_keyboard
{
    "bonusInformation" => [],
             "message" => "",
             "success" => true
}

Agora vamos procurar o botão de novo:

irb(main):052:0> query ("android.widget.Button")
[
    [0] {
                     "class" => "android.support.v7.widget.AppCompatButton",
                       "tag" => nil,
               "description" => "android.support.v7.widget.AppCompatButton{3b046ce VFED..C.. ........ 0,101-660,208 #7f0c0051 app:id/btnChamaBuscaCEP}",
                        "id" => "btnChamaBuscaCEP",
                      "text" => "Buscar",
                   "visible" => true,
                      "rect" => {
              "height" => 107,
               "width" => 660,
                   "y" => 291,
                   "x" => 30,
            "center_x" => 360,
            "center_y" => 344
        },
                   "enabled" => true,
        "contentDescription" => nil
    }
]

E por fim, vamos dar um touch nele =):

irb(main):053:0> touch ("android.support.v7.widget.AppCompatButton")
nil
```
Show de bola =) agora sabemos como interagir com nosso aplicativo através do console do calabash.

Próximo passo será criando nosso arquivo feature e realizando os testes via cucumber =).
