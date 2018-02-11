require('pg')

require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :customer_id, :film_id
  attr_reader :id

  def initialize( options )
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2)
    RETURNING id"
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE tickets SET customer_id = $1, film_id = $2
    WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  # def update_budgets()
  #   sql = "UPDATE customer SET funds = (customer.funds - $1)
  #         WHERE id = $2"
  #   values = [@film_id.price, @id]
  #   SqlRunner.run( sql,values )
  #
  # end

  def self.all()
    sql = "SELECT * FROM tickets"
    viewers = SqlRunner.run(sql)
    return viewers.map{|viewer| Ticket.new(viewer)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
