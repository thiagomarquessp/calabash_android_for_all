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
