require_relative '../app/models/dog.rb'
require_relative '../app/models/owner.rb'

data1 = {username: 'McFly', password: "88mph"}
data2 = {username: 'AVentura', password: "alrighty-then"}
owner1 = Owner.create(data1)
owner2 = Owner.create(data2)

Dog.create(name: "fido", breed: "lab", age: 5, description: "Ruff", owner_id: owner1.id)
Dog.create(name: "oscar", breed: "pug", age: 2, description: "actually", owner_id: owner1.id)
Dog.create(name: "rufus", breed: "corgi", age: 5, description: "No stay out of that!", owner_id: owner2.id)
Dog.create(name: "odie", breed: "beagle", age: 2, description: "Happy Man", owner_id: owner2.id)
