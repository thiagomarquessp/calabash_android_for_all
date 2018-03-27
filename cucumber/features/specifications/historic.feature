Feature: Validate historic data

I as user,
I want to validate all historic zipcode in my app

Background:
  Given I press the Buscar Cep button
  When entering a valid zip code
  And I press the buscar button
  Then the zip is found successfully

@historic
Scenario: Validate historic
  Given I enter on historic screen
  Then I see the all historic zipcode
