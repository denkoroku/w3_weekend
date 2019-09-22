require( 'pry' )
require_relative( 'models/customer.rb' )
require_relative( 'models/film.rb' )
require_relative( 'models/ticket.rb' )

# basic setup

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'Fred', 'funds' => '100'})
customer2 = Customer.new({'name' => 'Bob', 'funds' => '150'})
customer3 = Customer.new({'name' => 'Jo', 'funds' => '1000'})
customer1.save()
customer2.save()
customer3.save()


film1 = Film.new({'title' => 'Matrix', 'price' => 5 })
film2 = Film.new({'title' => 'Crouching Tiger Hidden Dragon', 'price' => 6 })
film3 = Film.new({'title' => 'The Handmaids Tale', 'price' => 8 })
film1.save
film2.save
film3.save

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket2 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket4 = Ticket.new({'customer_id' => customer3.id, 'film_id' => film2.id})
ticket1.save
ticket2.save
ticket3.save
ticket4.save

# Run any methods





#pry needs to not be on the last line so add nil after
binding.pry
nil
