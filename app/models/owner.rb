class Owner < ActiveRecord::Base
  has_secure_password
  has_many :owner_dogs
  has_many :dogs, through: :owner_dogs 
end
