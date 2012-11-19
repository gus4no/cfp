Given /^a regular User exists$/ do
  @user = User.new(:email => 'regular@example.com')
  @user.password              = '123456'
  @user.password_confirmation = @user.password
  @user.save
end

Given /^that user is logged in$/ do
  visit root_path
  fill_in 'Email'    , :with => @user.email
  fill_in 'Password' , :with => @user.password

  click_button 'Sign in'
end