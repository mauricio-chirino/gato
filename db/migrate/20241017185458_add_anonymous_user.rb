class AddAnonymousUser < ActiveRecord::Migration[7.2]
  def change
    def up
    User.create!(email: "anonimo@ejemplo.com", password: "password123", username: "Anonimo") unless User.exists?(email: "anonimo@ejemplo.com")
  end

  def down
    User.find_by(email: "anonimo@ejemplo.com").destroy if User.exists?(email: "anonimo@ejemplo.com")
  end
  end
end
