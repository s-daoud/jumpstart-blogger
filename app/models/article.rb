class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").map { |el| el.strip.downcase }.uniq
    new_or_found_tags = tag_names.map { |el| Tag.find_or_create_by(name: el) }
    self.tags = new_or_found_tags
  end
end
