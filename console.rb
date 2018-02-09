require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/customers.rb')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()

customer1 = Customer.new ({
  'name' => 'Big Pete',
  'funds' => 100
  });
customer1.save()

film1 = Film.new({
  'title' => 'Dawn of the Dead',
  'price' => 15
  });
film1.save

ticket1 = Ticket.new ({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  });
ticket1.save()






binding.pry
nil
