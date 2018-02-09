require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/customers.rb')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new ({
  'name' => 'Big Pete',
  'funds' => 100
  });
customer1.save()
customer2 = Customer.new ({
  'name' => 'Small Mark',
  'funds' => 150
  });
customer2.save()
customer3 = Customer.new ({
  'name' => 'Average Joe',
  'funds' => 30
  });
customer3.save()

film1 = Film.new({
  'title' => 'Dawn of the Dead',
  'price' => 15
  });
film1.save
film2 = Film.new({
  'title' => 'Shaun of the Dead',
  'price' => 10
  });
film2.save
film3 = Film.new({
  'title' => 'Day of the Dead',
  'price' => 25
  });
film3.save

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  });
ticket1.save()
ticket2 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film3.id
  });
ticket2.save()
ticket3 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film1.id
  });
ticket3.save()
ticket4 = Ticket.new ({
  'customer_id' => customer2.id,
  'film_id' => film3.id
  });
ticket4.save()
ticket5 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film1.id
  });
ticket5.save()
ticket6 = Ticket.new ({
  'customer_id' => customer3.id,
  'film_id' => film2.id
  });
ticket6.save()






binding.pry
nil
