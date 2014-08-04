module UsersHelper

  def format_member_since_date(user)
    join_date = user.created_at
    join_date.strftime("Member Since %B %Y")
  end

  def profile_image_for(user)
    gravatar_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}"
    image_tag(gravatar_url, :alt => user.name)
  end

end
