require_relative("../spec_helper")

describe "Editing a user" do

	it "Changes a newly-created users name" do
		visit signup_url
		
		fill_in "Name", 						:with => "Test"
		fill_in "Email", 						:with => "test@example.com"
		fill_in "Username",					:with => "tester"
		fill_in "Password", 				:with => "secret"
		fill_in "Confirm Password", :with => "secret"

		click_on "Create Account"

		click_on "Edit Account"

		fill_in "Name", :with => "Test2"

		click_on "Update Account"

		expect(current_path).to eql(user_path(User.last))
		expect(page).to have_text("Test2")
		expect(page).to have_text("Account successfully updated!")
	end

	it "Logs in and changes a users email" do
		u = User.create!(user_attributes)
		sign_in(u)

		click_on "Edit Account"
		fill_in "Email", :with => "shrimp@example.com"
		click_on "Update Account"

		expect(page).to have_text("shrimp@example.com")
		expect(page).to have_text("Account successfully updated!")
	end
end