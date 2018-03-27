# De boca no Calabash (Vamo Porra!)

Parabéns cavaleiro, agora estamos em nossa última batalha, que será travada com nosso bom e velho cucumber e nossas especificações por exemplo. Mais precisamente usaremos gherkin com  para nossos testes de aceitação e vamos usar nosso framework para automação (calabash android) como arqueiros e bem .. vamos ao ponto rsrsr (empolgação com guerras).

Para maiores detalhes sobre cucumber, acessem [aqui](https://cucumber.io/).

De uma forma legal de entender, vamos escrever uma especificação, onde cada linha será transformada em código, que vai executar dentro do nosso aplicativo modelo.

Algumas palavras são chaves para nossa especificação: Given (Dado), When (Quando), And (E) e Then (Então).

Lembra da nossa estrutura básica que criamos com o comando "calabash-android gen"?? Pois será exatamente na pasta specifications que nossas especificações vão ficar. Cada especificação deverá ter a extensão ".feature", por exemplo, "zipcode.feature". No nosso caso, teremos apenas duas features, "Zipcode.feature" e "historic.feature", com o seguinte conteúdo:

```ruby
Feature: Find Zipcode
  As a apprentice I want the find a valid CEP.

@valid_zipcode
Scenario: As a user, I want find a valid CEP
  Given I press the Buscar Cep button
  When entering a valid zip code
  And I press the buscar button
  Then the zip is found successfully

@invalid_zipcode
Scenario: As a user, I want find a invalid CEP
  Given I entering an invalid zip code data
  Then the message Por favor informe um CEP válido is showed
```
Para execução do nosso teste,
Vamos agora executar o nosso arquivo de feature com o comando "calabash-android run busca_cep.apk" e vai trazer o seguinte resultado:
```ruby

Reparem que eu utilizei uma tag em cada scenario (@valid_zipcode e @invalid_zipcode) para efeitos de querer executar apenas um scenario por vez. E falando em execução, uma vez que criamos nossa feature podemos fazer duas coisas: 1. Executar para que o próprio framework gere os "métodos pendentes de implementação" ou 2. gerar na mão. Geralmente eu gosto de executar para que ele mesmo crie, até mesmo pra ter certeza que eu não fiz nada de errado na escrita da feature. Para execução, navegar até a pasta cucumber e executar o comando:

```ruby
Para criar o servidor de testes:

calabash-android resign busca_cep.apk --tags @valid_zipcode

Para execução:

calabash-android run busca_cep.apk --tags @valid_zipcode
```

A execução nesse caso foi por tag, mas se quisessemos executar tudo de uma vez, bastaria executar o comando sem o --tags.

Com o resultado apresentado, que deverá ser semelhante a esse:

```ruby
Feature: Find Zipcode
  As a apprentice I want the find a valid CEP.

  @valid_zipcode
  Scenario: As a user, I want find a valid CEP # features/specifications/zipcode.feature:5
    Given I presss the Buscar Cep button       # features/specifications/zipcode.feature:6
    When enterings a valid zip code            # features/specifications/zipcode.feature:7
    And I presss the buscar button             # features/specifications/zipcode.feature:8
    Then the zips is found successfully        # features/specifications/zipcode.feature:9

1 scenario (1 undefined)
4 steps (4 undefined)
0m9.372s

You can implement step definitions for undefined steps with these snippets:

Given(/^I press the Buscar Cep button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^entering a valid zip code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press the buscar button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the zip is found successfully$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
```

Esse é o resultado sempre que tiver alguma feature nova que necessita ser implementada e o processo daí em diante é simples, basta apenas copiar do primeiro Given até o último end, depois criar um arquivo dentro da pasta step_definitions com o nome que lhe achar melhor, no nosso caso, vamos chamar de find-valid-zipcode.rb e observe que agora estamos falando de um arquivo de extensão ruby, pois nele que vamos implementar os steps descritos nas features =). Bem, esse arquivo deverá ficar assim:

```ruby
Given(/^I press the Buscar Cep button$/) do
  touch("* id:'btnCep'")
end

When(/^entering a valid zip code$/) do
  enter_text("* id:'edtCep'", "05433001")
end

And(/^I press the buscar button$/) do
  touch("* id:'btnChamaBuscaCEP'")
end

Then(/^the zip is found successfully$/) do
  hide_soft_keyboard
  has_text?("05433001")
  has_text?("Rua Girassol")
  press_back_button
end
```
Como vimos na parte de [lidando com os elementos](https://github.com/thiagomarquessp/calabash_android_for_all/blob/master/lidando_com_elementos.md) os comandos que testamos no console do calabash foram copiados e colados, ou seja, deu certo no console, vai dar certo ai também na implementaçao dos steps.

Obs.: Caso queiram saber um pouco mais sobre a gem Faker (usada no método de busca de cep inválido), deem uma olhada na iniciativa [capybara for all parte II](https://github.com/thiagomarquessp/capybara_for_all_p2/blob/master/trabalhando_com_faker_generator.md). Lá vai te dar um bom overview sobre essa gem fantástica de dados aleatórios.

Bom, vamos agora executar nossa automação. Então conecte seu device no computador, USB com depuração ativa, PTP ativo e digite "calabash_android run busca_cep.apk --tags @valid_zipcode" e veja a mágica acontecer ......
....
.....
......
.......

E o resultado vai ser esse:

```ruby
Feature: Find Zipcode
  As a apprentice I want the find a valid CEP.

  @valid_zipcode
  Scenario: As a user, I want find a valid CEP # features/specifications/zipcode.feature:5
    Given I press the Buscar Cep button        # features/step_definitions/find-valid-zipcode.rb:1
    When entering a valid zip code             # features/step_definitions/find-valid-zipcode.rb:5
    And I press the buscar button              # features/step_definitions/find-valid-zipcode.rb:9
    Then the zip is found successfully         # features/step_definitions/find-valid-zipcode.rb:13

1 scenario (1 passed)
4 steps (4 passed)
0m11.920s
```

Lindo neh. Executou lindamente no nosso device, com cucumber e tudo. Agora conseguimos fazer testes de aceite com calabash e cucumber.


Ponto a ser levantado:

No nosso arquivo [lidando com os elementos](https://github.com/thiagomarquessp/calabash_android_for_all/blob/master/lidando_com_elementos.md), vimos como buscar os elementos de nosso aplicativo através do console certo?

E se você reparou, nos nossos arquivos .rb eu garanti o funcionamento no console e coloquei em um arquivo simplesmente para ele executar o comando quando passar pelo método, então o que temos é o teste no console virando realidade:

Tudo isso eu consegui testar no console, eu apenas abstrai do console para o nosso arquivo de steps. Na nossa estrutura do projeto, temos um arquivo dentro da pasta support chamado "app_life_cycle_hooks.rb" com o seguinte conteúdo:

```ruby
Before do |scenario|
  start_test_server_in_background
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  shutdown_test_server
end

Ou seja, no Before ele fala: "Olha ... antes de cada teste, da um start no servidor com o comando start_test_server_in_background, o mesmo comando que a gente usa pra entrar no console =)" e no After ele fala "Se falhar, me tira um screenshot da tela pra eu ver onde ta o bug".

Com isso, eu consigo usar os comandos de busca de elementos, interagir com eles e se der pau, consigo um screenshot e mostrar pro Dev onde está o problema.
```
O mesmo se aplica aos outros arquivos de feature e arquivos de steps. Para não se perder, deem um clone no projeto e vejam a estrutura e como ela foi pensada para execução e estudo.

Bem pessoal, espero que tenham gostado dessa introdução do calabash android.

A apk ta disponível. Façam fork e brinquem a vontade.

Qualquer dúvida ou sugestão ou crítica (essa principalmente) me mandem email: thiagomarquessp@gmail.com

\o/
