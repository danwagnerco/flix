require_relative("../spec_helper")

describe "Favoriting a movie" do

  before do
    @movie = Movie.create!(movie_attributes)
    @user  = User.create!(user_attributes)
    sign_in(@user)
  end
  
  context "when the movie isnt already a favorite" do
    it "shows a Favorite! button" do
      visit movie_url(@movie)

      expect(page).to have_button("Favorite!")
    end

    it "increments Favorites after clicking Favorite" do
      visit movie_url(@movie)

      expect {
        click_button "Favorite!"
      }.to change(@user.favorites, :count).by(1)
      expect(page).to have_text("Thanks for favoriting!")
      expect(page).to have_text("1 Fan")
    end
  end

  context "the movie is already a favorite" do
    it "shows an Unfavorite! button if already a Favorite" do
      visit movie_url(@movie)
      click_button "Favorite!"

      expect(page).to have_button("Unfavorite!")
    end

    it "decrements Favorites after clicking Unfavorite" do
      visit movie_url(@movie)
      click_button "Favorite!"

      expect(page).to have_text("1 Fan")
      expect {
        click_button "Unfavorite!"
      }.to change(@user.favorites, :count).by(-1)
      expect(page).to have_text("Sorry you unfavorited it!")
      # expect(page).to have_text("0 Fans") <~ don't list fans if there are none
      expect(page).to have_button("Favorite!")
    end
  end
end
