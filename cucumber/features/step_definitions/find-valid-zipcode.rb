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
