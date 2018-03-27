Given(/^I entering an invalid zip code data$/) do
  invalid_cep = Faker::Base.numerify('054#').to_s
  touch("* id:'btnCep'")
  enter_text("* id:'edtCep'", invalid_cep)
  touch("* id:'btnChamaBuscaCEP'")
end

Then(/^the message Por favor informe um CEP válido is showed$/) do
  has_text?("Por favor informe um CEP válido")
end
