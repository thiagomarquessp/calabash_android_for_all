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
