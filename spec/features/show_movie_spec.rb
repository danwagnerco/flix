require 'spec_helper'

describe "Viewing an individual movie" do
  it "shows the movie's details" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_text(movie.title)
    expect(page).to have_text(movie.rating)
    expect(page).to have_text(movie.description)
    expect(page).to have_text(movie.released_on)
    expect(page).to have_text(movie.cast)
    expect(page).to have_text(movie.director)
    expect(page).to have_text(movie.duration)
    expect(page).to have_selector("img[src$='#{movie.image_file_name}']")
  end

  it "displays a movies fans and genres in sidebar" do
    movie  = Movie.create!(movie_attributes)
    user   = User.create!(user_attributes)
    genre  = Genre.create(:name => "Genre1")

    movie.fans << user
    movie.genres << genre

    visit movie_url(movie)

    within("aside#sidebar") do
      expect(page).to have_text(user.name)
      expect(page).to have_text(genre.name)
    end

  end

  it "contains the name of the movie and year in the page title" do
    movie = Movie.create!(movie_attributes)

    visit movie_url(movie)

    expect(page).to have_title("Flix - #{movie.title} (#{movie.released_on.year})")
  end
  
  it "shows the total gross if the total gross exceeds $50M" do
    movie = Movie.create!(movie_attributes(total_gross: 60000000))

    visit movie_url(movie)

    expect(page).to have_text("$60,000,000.00")
  end

  it "shows 'Flop!' if the total gross is less than $50M" do
    movie = Movie.create!(movie_attributes(total_gross: 40000000))

    visit movie_url(movie)

    expect(page).to have_text("Flop!")
  end

  it "has an SEO-friendly URL" do
    movie = Movie.create!(movie_attributes(:title => "X-Men: The Last Stand"))
    visit movie_url(movie)

    expect(current_path).to eq("/movies/x-men-the-last-stand")
  end

end