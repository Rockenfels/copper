# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app: controllers inherit from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database: models/migrations inherit from ActiveRecord Base/Migration; ]
- [x] Include more than one model class (e.g. User, Post, Category): app contains both an owner and a dog class
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts): the owner class has_many dogs that it owns.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User): each instance of the dog class belongs_to an individual owner.
- [x] Include user accounts with unique login attribute (username or email): all users are required to sign up for an account with a unique username (email addresses accepted) and password combination.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying: owners can create and view instances of their own dogs for their profile, edit their information, remove them from the site, or add another dog to their family by adopting one of the random dogs they are able to view.
- [x] Ensure that users can't modify content created by other users: controllers check to make sure both that there is a user logged in, and that they are the dog's owner before any changes can be made
- [x] Include user input validations: user's password is encrypted at signup and validated at login
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
