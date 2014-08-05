require_relative("../spec_helper")

describe "User sign in" do

	it "shows the sign in form" do
		User.create!(user_attributes)
		visit root_url
		click_on "Sign In"

		expect(current_path).to eql(signin_path)
		expect(page).to have_text("Email")
		expect(page).to have_text("Password")

		# fill_in "Email",    :with => "user@example.com"
		# fill_in "Password", :with => "secret"

		# click_on "Log In"
	end

end