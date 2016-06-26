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
