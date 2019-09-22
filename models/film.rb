require_relative('../db/sql_runner')

class Film

  attr_reader :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end


# Create
  def save()
    sql = "INSERT INTO films(title,price)VALUES($1, $2)RETURNING *"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

#Read
  def Film.all()
    sql = "SELECT * FROM films"
    film_array = SqlRunner.run(sql)
    result = film_array.map { |film| Film.new(film) }
    return result
  end

#Update
  def update
    sql = "UPDATE films SET title = $1, price = $2 WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

#Delete
  def Film.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end


#Which Customers are coming to see film
  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [@id]
    customer_array = SqlRunner.run(sql, values)
    result = customer_array.map { |customer| Customer.new( customer ) }
    return result
  end
end
