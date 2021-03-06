class Group < ActiveRecord::Base
  has_many :group_memberships
  has_many :members, through: :group_memberships
  has_many :likes, as: :likable,  dependent: :destroy

  has_many :group_images
  has_many :images, through: :group_images
  has_many :activities

  validates :name, presence: true
end
