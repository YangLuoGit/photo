class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  def author_name
    user.try(:display_name) || "Guest"
  end

end
