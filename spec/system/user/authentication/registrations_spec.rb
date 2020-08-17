RSpec.feature "User", :type => :feature do
  scenario "Sign Up" do
    visit "/users/new"

    fill_in "Name", with: "First author" # Điền tên author vào textfiled Name
    fill_in "Email", with: "nguyensiviet1999@gmail.com" # Điền tuổi Email vào textfield Email
    fill_in "Password", with: "123456" # Điền tuổi password vào textfield password
    fill_in "Password confirmation", with: "123456" # Điền tuổi password confirm vào textfield password confirm
    click_button "Sign Up Page" # Click vào button 'Create Author'

    expect(page).to have_text("Please check your email to activate your account.")
  end
  describe "the signin process", type: :feature do
    before :each do
      User.create(name: "zcxzcx", email: "user@example.com", password: "password", password_confirmation: "password")
    end

    it "signs me in" do
      visit "/sessions/new"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      click_button "Log in"
      expect(page).to have_content "Account not activated."
    end
  end
end
# it "have title: 評価対象スキルの設定" do
#   Sidekiq::Testing.inline!
#   visit "/users/sign-up/"

#   fill_in "user_email", with: email

#   # アカウント発行
#   expect do
#     click_on "利用規約に同意して登録"
#   end.to change(ActionMailer::Base.deliveries, :count).by(1)
#     .and change(User, :count).by(1)
#   expect(page).to have_current_path('/users/sign-up/complete/')
#   expect(page).to have_content("仮ユーザー登録完了")

#   # 本人確認＆パスワードセット
#   mail = ActionMailer::Base.deliveries.last
#   reset_url = %r{(?<url>/users/setup-password/edit\?reset_password_token=.+)"}.match(mail.body.to_s)["url"]
#   visit reset_url
#   expect(page).to have_content("パスワード設定")

#   fill_in "user_password", with: "test.123456789"
#   fill_in "user_password_confirmation", with: "test.123456789"

#   expect do
#     click_on "進む"
#   end.to change(ActionMailer::Base.deliveries, :count).by(1)
#   expect(page).to have_current_path("/users/simulations/new/")

#     visit "/users/evaluation-settings/edit/"
#     expect(page).to have_content "評価対象スキルの設定"
# end
