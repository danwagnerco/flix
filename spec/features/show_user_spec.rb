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

  it "shows favorite movies in sidebar" do
    user  = User.create!(user_attributes)
    movie = Movie.create!(movie_attributes)
    user.favorite_movies << movie

    sign_in(user)
    visit user_url(user)

    within("aside#sidebar") do
      expect(page).to have_text(movie.title)
    end
  end

  it "shows the users name in the page title" do
    user = User.create!(user_attributes)

    sign_in(user)
    visit user_url(user)

    expect(page).to have_title("Flix - #{user.name}")
  end

end
