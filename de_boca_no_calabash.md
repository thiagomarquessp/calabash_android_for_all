# De boca no Calabash (Vamo Porra!)

Parabéns cavaleiro, agora estamos em nossa última batalha, que será travada com nosso bom e velho cucumber e nossas especificações por exemplo. Mais precisamente usaremos BDD com Cucumber para nossos testes de aceitação e vamos usar nosso framework para automação (calabash android) como arqueiros e bem .. vamos ao ponto rsrsr (empolgação com guerras).

Para maiores detalhes sobre cucumber, acessem [aqui](https://cucumber.io/).

De uma forma legal de entender, vamos escrever uma especificação, onde cada linha será transformada em código, que vai executar dentro do nosso aplicativo modelo.

Algumas palavras são chaves para nossa especificação: Given (Dado), When (Quando), And (E) e Then (Então).

Lembra da nossa estrutura básica que criamos com o comando "calabash-android gen"?? Pois será exatamente na pasta specifications que nossas especificações vão ficar. Cada especificação deverá ter a extensão ".feature", por exemplo, "find_cep.feature". E dentro desse arquivo, vamos colocar 3 cenários de teste (Buscar um cep válido, Buscar um cep inválido e por fim, buscar no histórico o cep que digitamos). O arquivo vai ficar mais ou menos assim:

```ruby
Feature: Find CEP
  As a apprentice I want the find a valid CEP.

Scenario: As a user, I want find a valid CEP

  Given I press the Buscar Cep button
  When entering the zip code data
  And I press the buscar button
  Then I see the text "Rua Girassol"
  And I see the text "Vila Madalena"
  And I see the text "São Paulo / SP"
  And I go back

Scenario: As a user, I want find a invalid CEP

  Given I press the Buscar Cep button
  When entering the invalid zip code data
  And I press the buscar button
  Then I wait for "Por favor informe um CEP válido." to appear

Scenario: As a user, I want validate the historic wanted

  Given I press the Histórico button
  When I see the text "05433-001"
```

Vamos agora executar o nosso arquivo de feature com o comando "calabash-android run busca_cep.apk" e vai trazer o seguinte resultado:

```ruby
Feature: Find CEP
  As a apprentice I want the find a valid CEP.

  Scenario: As a user, I want find a valid CEP # features/specifications/find_cep.feature:4
    Given I press the Buscar Cep button        # features/specifications/find_cep.feature:6
    When entering the zip code data            # features/specifications/find_cep.feature:7
    And I press the buscar button              # features/specifications/find_cep.feature:8
    Then I see the text "Rua Girassol"         # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I see the text "Vila Madalena"         # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I see the text "São Paulo / SP"        # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I go back                              # calabash-android-0.7.3/lib/calabash-android/steps/navigation_steps.rb:1

  Scenario: As a user, I want find a invalid CEP                 # features/specifications/find_cep.feature:14
    Given I press the Buscar Cep button                          # features/specifications/find_cep.feature:16
    When entering the invalid zip code data                      # features/specifications/find_cep.feature:17
    And I press the buscar button                                # features/specifications/find_cep.feature:18
    Then I wait for "Por favor informe um CEP válido." to appear # calabash-android-0.7.3/lib/calabash-android/steps/progress_steps.rb:22

  Scenario: As a user, I want validate the historic wanted # features/specifications/find_cep.feature:21
    Given I press the Histórico button                     # features/specifications/find_cep.feature:23
    When I see the text "05433-001"                        # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1

3 scenarios (3 undefined)
13 steps (6 skipped, 7 undefined)
0m38.869s

You can implement step definitions for undefined steps with these snippets:

Given(/^I press the Buscar Cep button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^entering the zip code data$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I press the buscar button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^entering the invalid zip code data$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I press the Histórico button$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
```

O que temos que observar é:

```ruby
3 scenarios (3 undefined)
13 steps (6 skipped, 7 undefined)

Significa que houveram 13 steps para realização de todos os meus 3 cenários. 6 deles foram pulados porque eles estão já pré definidos (cenários que no fim eu passo o valor exato do teste, por exemplo "Rua Girassol", "Vila Madalena", "05433001") e 7 que não foram definidos e se tu observar no final da execução, nossos steps estão mais ou menos assim:

  Given(/^I press the Buscar Cep button$/) do
    pending # Write code here that turns the phrase above into concrete actions
  end

Ou seja, cada step vira um método, e esse método é composto por uma expressão regular (RegEx), um "do" e um "end". O "pending" é onde vamos colocar nossos comandos para que possa ser executado de forma automática sacou?

Sabe qual é o mais legal disso tudo??? Uma vez definido o método, de qualquer arquivo .feature que você o chamar, não vai precisar mais defini-lo.
```

Bem, agora é a parte onde vamos ter um pouco de trabalho, vamos pegar cada step não definido (undefined) e vamos colocar nos arquivos a serem executados. Os arquivos vão ficar na pasta "step_definitions" com a extensão ".rb". O primeiro arquivo vai ser chamar "find_cep.rb" e vai ter o seguinte conteúdo:

```ruby
# encoding: utf-8
#!/usr/bin/env ruby
  Given(/^I press the Buscar Cep button$/) do
    touch("android.widget.Button id:'btnCep'")
  end

  When(/^entering the zip code data$/) do
    enter_text("android.widget.EditText id:'edtCep'", '05433-001')
  end

  And(/^I press the buscar button$/) do
    sleep 03
    touch("android.widget.Button id:'btnChamaBuscaCEP'")
    hide_soft_keyboard
  end
```

O segundo arquivo vai se chamar "find_invalid_cep.rb" e vai conter o seguinte conteúdo:

```ruby
# encoding: utf-8
#!/usr/bin/env ruby

When(/^entering the invalid zip code data$/) do
  @invalid_cep = Faker::Base.numerify('054#').to_s
  enter_text("android.widget.EditText id:'edtCep'", @invalid_cep)
end
```

E por fim, nosso terceiro arquivo vai se chamar "verify_historic.rb" e vai conter o seguinte conteúdo:

```ruby
# encoding: utf-8
#!/usr/bin/env ruby

Given(/^I press the Histórico button$/) do
  step "I press the Buscar Cep button"
  step "entering the zip code data"
  hide_soft_keyboard
  step "I press the buscar button"
  sleep 01
  step "I go back"
  sleep 01
  touch("android.widget.Button id:'btnHistorico'")
end

When(/^I select the CEP wanted$/) do
  tap_mark("android.widget.ListView id:listView")
  sleep 10
end
```

Obs.: Caso queiram saber um pouco mais sobre a gem Faker (usada no método de busca de cep inválido), deem uma olhada na iniciativa capybara for all parte II (https://github.com/thiagomarquessp/capybara_for_all_p2/blob/master/trabalhando_com_faker_generator.md). Lá vai te dar um bom overview sobre essa gem fantástica de dados aleatórios.

Bom, vamos agora executar nossa automação. Então conecte seu device no computador, USB com depuração ativa, PTP ativo e digite "calabash_android run busca_cep.apk" e veja a mágica acontecer ......
....
.....
......
.......

E o resultado vai ser esse:

```ruby
Calabash-MacBook-Pro:cucumber phoenix$ calabash-android run busca_cep.apk

Feature: Find CEP
  As a apprentice I want the find a valid CEP.

  Scenario: As a user, I want find a valid CEP # features/specifications/find_cep.feature:4
    Given I press the Buscar Cep button        # features/step_definitions/find_cep.rb:3
    When entering the zip code data            # features/step_definitions/find_cep.rb:7
    And I press the buscar button              # features/step_definitions/find_cep.rb:11
    Then I see the text "Rua Girassol"         # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I see the text "Vila Madalena"         # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I see the text "São Paulo / SP"        # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1
    And I go back                              # calabash-android-0.7.3/lib/calabash-android/steps/navigation_steps.rb:1

  Scenario: As a user, I want find a invalid CEP                 # features/specifications/find_cep.feature:14
    Given I press the Buscar Cep button                          # features/step_definitions/find_cep.rb:3
    When entering the invalid zip code data                      # features/step_definitions/find_invalid_cep.rb:4
    And I press the buscar button                                # features/step_definitions/find_cep.rb:11
    Then I wait for "Por favor informe um CEP válido." to appear # calabash-android-0.7.3/lib/calabash-android/steps/progress_steps.rb:22

  Scenario: As a user, I want validate the historic wanted # features/specifications/find_cep.feature:21
    Given I press the Histórico button                     # features/step_definitions/verify_historic.rb:4
    When I see the text "05433-001"                        # calabash-android-0.7.3/lib/calabash-android/steps/assert_steps.rb:1

3 scenarios (3 passed)
13 steps (13 passed)
0m30.871s
```

Lindo neh. Executou lindamente no nosso device, com cucumber e tudo. Agora conseguimos fazer testes de aceite com calabash e cucumber.


Ponto a ser levantado:

No nosso arquivo "lidando com elementos", vimos como buscar os elementos de nosso aplicativo através do console certo?

E se você reparou, nos nossos arquivos .rb eu abstrai do console e coloquei em um arquivo simplesmente para ele executar o comando quando passar pela RegEx, então o que temos é o teste no console virando realidade:

```ruby
touch("android.widget.Button id:'btnCep'");
enter_text("android.widget.EditText id:'edtCep'", @invalid_cep);
hide_soft_keyboard;
tap_mark("android.widget.ListView id:listView").
```

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

Bem pessoal, espero que tenham gostado dessa introdução do calabash android. Vão haver mais partes, o próximo vou falar de conceitos mais avançados, como usar After e Before nos meus testes, assim como outras gems para dar um UP =).

A apk ta disponível. Façam fork e brinquem a vontade.

Qualquer dúvida ou sugestão ou crítica (essa principalmente) me mandem email: thiagomarquessp@gmail.com

\o/
