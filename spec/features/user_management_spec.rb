require "spec_helper"

feature "user sign up" do
  scenario "I can sign up as a new user" do
    expect { sign_up(build :user) }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")
  end

  scenario "with a password that does not match" do
    expect { sign_up() }.not_to change(User, :count)
    expect(current_path).to eq "/users"
    expect(page).to have_content "Password and confirmation password do not match"
  end

  scenario "without an email" do
    expect { sign_up() }.not_to change(User, :count)
    expect(current_path).to eq "/users"
    expect(page).to have_content "Please enter a valid email address"
  end

  def sign_up(user)
    visit "/users/new"
    expect(page.status_code).to eq 200
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button "Sign up"
  end

end
