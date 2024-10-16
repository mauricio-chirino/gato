# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :text
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :reactions, dependent: :destroy



  scope :post_selec, -> (post_id) { where(id: post_id) }

end


