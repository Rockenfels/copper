require_relative '../app/models/dog.rb'
require_relative '../app/models/owner.rb'

data1 = {username: 'McFly', password: "88mph"}
data2 = {username: 'AVentura', password: "alrighty-then"}
owner1 = Owner.create(data1)
owner2 = Owner.create(data2)

Dog.create(name: "Fido", breed: "Lab", age: 5, gender: 'Male', description: "Ruff around the edges, but a real sweetheart.", owner_id: owner1.id)
Dog.create(name: "Oscar", breed: "Pug", age: 2, gender: 'Female', description: "Loves to nap and dig!", owner_id: owner1.id)
Dog.create(name: "Rufus", breed: "Corgi", age: 5, gender: 'Male', description: "No stay out of that!", owner_id: owner2.id)
Dog.create(name: "Odie", breed: "Beagle", age: 2, gender: 'Female', description: "Happy lady who loves to fetch.", owner_id: owner2.id)
