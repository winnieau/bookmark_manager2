require "spec_helper"

feature "user sign up" do
  context "can sign up" do
    scenario "I can sign up as a new user" do
      expect { sign_up(build :user) }.to change(User, :count).by(1)
      expect(page).to have_content("Welcome, alice@example.com")
      expect(User.first.email).to eq("alice@example.com")
    end
  end
  context "user cannot sign up" do
    scenario "with a password that does not match" do
      person = build :user, password: "something else"
      expect { sign_up(person) }.not_to change(User, :count)
      expect(current_path).to eq "/users"
      expect(page).to have_content "Password and confirmation password do not match"
    end
    scenario "without an email" do
      user = build :user, email: ""
      expect { sign_up(user) }.not_to change(User, :count)
      expect(current_path).to eq "/users"
      expect(page).to have_content "Please enter a valid email address"
    end
    scenario "with already used email address" do
      user = create :user
      expect { sign_up(user) }.not_to change(User, :count)
      expect(current_path).to eq "/users"
      expect(page).to have_content "Email already registered"
    end
  end
end

feature "user signing in" do
  let(:user) { create :user }
  context "user signs in" do
    scenario "if no problems" do
      sign_in(password: user.password, email: user.email)
      expect(current_path).to eq "/"
      expect(page).to have_content "Welcome, #{user.email}"
    end
  end
  context "user cannot sign in" do 
    scenario "with wrong password" do
      sign_in(email: user.email, password: !user.password)
      expect(current_path).to eq "/sessions"
      expect(page).to have_content "Email or password incorrect"
    end
  end
end

feature "user signing out" do
  let(:user) { create :user }
  scenario "can sign out" do
    sign_in(email: user.email, password: user.password)
    click_button "Sign out"
    expect(current_path).to eq "/"
    expect(page).not_to have_content "Welcome, #{user.email}"
  end
end










