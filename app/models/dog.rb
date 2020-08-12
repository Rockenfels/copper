class Dog < ActiveRecord::Base
  belongs_to: :users
  belongs_to: :shelters
end
