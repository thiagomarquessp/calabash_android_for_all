# encoding: utf-8
#!/usr/bin/env ruby

When(/^entering the invalid zip code data$/) do
  @invalid_cep = Faker::Base.numerify('054#').to_s
  enter_text("android.widget.EditText id:'edtCep'", @invalid_cep)
end
