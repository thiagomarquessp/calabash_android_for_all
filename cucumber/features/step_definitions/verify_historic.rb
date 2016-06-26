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
