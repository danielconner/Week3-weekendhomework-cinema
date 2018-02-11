require('pg')

require_relative('../db/sql_runner.rb')

class Screening

  attr_accessor :film_id, :time_of_screening
  attr_reader :id

  def initialize( options )
    @film_id = options['film_id'].to_i
    @time_of_screening = options['time_of_screening']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, time_of_screening) VALUES ($1, $2)
    RETURNING id"
    values = [@film_id, @time_of_screening]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end


  def delete()
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE screenings SET film_id = $1, time_of_screening =$2
    WHERE id = $3"
    values = [@film_id, @time_of_screening, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    showings = SqlRunner.run(sql)
    return showings.map{|showing| Screening.new(showing)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
