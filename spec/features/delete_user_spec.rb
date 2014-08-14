require_relative("../spec_helper")

describe "Deleting a user" do

	it "destroys the user and returns to root" do
		u = User.create!(user_attributes)
		sign_in(u)

		visit user_path(u)

		click_link "Delete Account"

		expect(current_path).to eql(root_path)
		expect(page).to have_text("Account successfully deleted!")

		visit users_path

		expect(page).not_to have_text(u.name)
	end

	it "signs the user out when deleting account" do
		u = User.create!(user_attributes)
		sign_in(u)

		click_link "Delete Account"

		expect(page).to have_link("Sign In")
		expect(page).not_to have_link("Sign Out")
	end

end
