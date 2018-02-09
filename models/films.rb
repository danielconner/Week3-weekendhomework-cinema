require('pg')

require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize( options )
    @title = options['title']
    @price = options['price'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
  end

  def update()
  sql = "UPDATE films SET title = $1, price =$2
    WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
  end

  def self.all()
  sql = "SELECT * FROM films"
  movies = SqlRunner.run(sql)
  return movies.map{|movie| Film.new(movie)}
  end

  def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id
    = tickets.customer_id WHERE tickets.film_id = $1"
    values = [@id]
    viewers = SqlRunner.run(sql, values)
    return viewers.map{|viewer| Customer.new(viewer)}
  end

end
