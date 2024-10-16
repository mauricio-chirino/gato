# == Schema Information
#
# Table name: reactions
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  post_id    :bigint           not null
#  like       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Reaction < ApplicationRecord
  # belongs_to :user
  # belongs_to :post

  belongs_to :user, optional: true  # Permitir reacciones anónimas
  belongs_to :post
  
  scope :likes, -> { where(like: true) }
  scope :dislikes, -> { where(like: false) }
end
