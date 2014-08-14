require_relative("../spec_helper")

describe "Showing a user page" do 

	it "shows name and email" do
		u1 = User.create!(:name                  => "Dan",
                  		:email                 => "dan@example.com",
                      :username              => "dadidas07",
                  		:password              => "secret",
                  		:password_confirmation => "secret"
                  		)

		sign_in(u1)

    visit user_url(u1)

		expect(page).to have_text(u1.name)
		expect(page).to have_link(u1.email)
    expect(page).to have_text(u1.username)
	end

end
