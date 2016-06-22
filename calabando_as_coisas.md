# Criando Features e Steps e executando

Bem, dado que estamos com o ambiente montado e pronto para desenvolvimento vamos precisar agora definir o local para iniciarmos. Geralmente eu coloco meus projetos em um local chamado workspace, mas fica a cargo de cada um.

Uma vez que temos nosso local para desenvolvimento, vamos precisar falar para o Calabash que vamos iniciar um projeto bem ali. E para isso, vamos dar o seguinte comando:

```ruby
calabash-android gen
```
Esse comando vai criar a estrutura básica proposta pelo próprio framwork da seguinte maneira:

```ruby
features
features/my_first.feature
features/step_definitions
features/step_definitions/calabash_steps.rb
features/support
features/support/env.rb
features/support/app_installation_hooks.rb
features/support/app_life_cycle_hooks.rb
features/support/hooks.rb
```

Essa é a estrutura proposta, porém, por uma questão de organização, eu costumo trabalhar da seguinte maneira:

```ruby
cucumber
cucumber/features
cucumber/features/specifications - Pasta chave para colocar meus arquivos .feature
cucumber/features/specifications/my_first.feature
cucumber/features/step_definitions
cucumber/features/step_definitions/calabash_steps.rb
cucumber/features/support
cucumber/features/support/env.rb
cucumber/features/support/app_installation_hooks.rb
cucumber/features/support/app_life_cycle_hooks.rb
cucumber/features/support/hooks.rb
```
Mas a forma de trabalho cada um tem a sua, portanto, fique a vontade para escolher a que melhor se adeque ao seu contexto.

Eu sempre gosto de trabalhar com uma pasta specifications para colocar dentro dela todas as minhas features bem organizadas e também o nome faz todo sentido.

O arquivo "my_first.feature" pode ser removido OK, eu vou ensinar como criar um arquivo legal para trabalhar.

Caso queira dar uma olhada, no próprio repositório a estrutura já está montada.

Bora para o terceiro arquivo da série: https://goo.gl/7EgCjz
