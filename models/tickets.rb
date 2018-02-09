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


end