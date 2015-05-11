class Photo < ActiveRecord::Base

  has_many :comments, :dependent => :destroy
  belongs_to :user

  has_attached_file :pic, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
  
  def can_edit_by_user?(user)
  	user && ( self.user == user || user.is_admin? )
  end

  def author_name
    user.try(:display_name) || "Guest"
  end

end
