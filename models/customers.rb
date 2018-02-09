require('pg')

require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize( options )
    @name = options['name']
    @funds = options['funds']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2)
    RETURNING id"
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def delete()
  sql = "DELETE FROM customers WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
  end

  def update()
  sql = "UPDATE customers SET name = $1, funds =$2
    WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
  end

  def self.all()
  sql = "SELECT * FROM customers"
  folks = SqlRunner.run(sql)
  return folks.map{|folk| Customer.new(folk)}
  end

  def self.delete_all()
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
  end

  def movies()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id
    = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map{|movie| Film.new(movie)}
  end

end
