class Image < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  belongs_to :gallery
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable,  dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

#   searchable do
#     text :name, :description
#     text :tags do
#       tags.map(&:name)
#     end
#   end
#
  def user
    gallery.user
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_string)
    tag_string.split(",").each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip.downcase)
      tags << tag
    end
  end

  def self.search(search_params)
    query = search_params[:query]
    tags = Tag.search(search_params)
    image_ids = Tagging.where(tag_id: tags).pluck(:image_id)
    where("name iLIKE :query OR description iLIKE :query OR id IN (:image_ids)", query: "%#{query.strip}", image_ids: image_ids)
  end
end
