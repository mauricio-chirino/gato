# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :post
  #belongs_to :user
  belongs_to :user, optional: true  # Permitir comentarios anónimos
end
