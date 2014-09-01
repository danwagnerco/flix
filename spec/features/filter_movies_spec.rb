require_relative("../spec_helper")

describe "Filter movies" do

  before do
    @hit_movie  = Movie.create!(movie_attributes(:total_gross => 1_000_000_000))
    @flop_movie = Movie.create!(movie_attributes(:total_gross => 1_000_000))
    @up_movie   = Movie.create!(movie_attributes(:released_on => 30.days.from_now))
    @re_movie   = Movie.create!(movie_attributes(:released_on => 1.days.ago))
  end

  context "visit the hits path" do
    it "shows only hits" do
      visit movies_url
      click_link "Hits"

      expect(current_path).to eq("/movies/filter/hits")
      expect(page).to have_text(@hit_movie.title)
      expect(page).not_to have_text(@flop_movie.title)
    end
  end

  context "visit the flops path" do
    it "shows only flops" do
      visit movies_url
      click_link "Flops"

      expect(current_path).to eq("/movies/filter/flops")
      expect(page).to have_text(@flop_movie.title)
      expect(page).not_to have_text(@hit_movie.title)
    end
  end

  context "visit the upcoming path" do
    it "shows only upcoming movies" do
      visit movies_url
      click_link "Upcoming"

      expect(current_path).to eq("/movies/filter/upcoming")
      expect(page).to have_text(@up_movie.title)
      expect(page).not_to have_text(@re_movie.title)
    end
  end

  context "visit the recent path" do
    it "shows only recent movies" do
      visit movies_url
      click_link "Recent"

      expect(current_path).to eq("/movies/filter/recent")
      expect(page).to have_text(@re_movie.title)
      expect(page).not_to have_text(@up_movie.title)
    end
  end

end
