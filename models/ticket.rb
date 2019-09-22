require_relative('../db/sql_runner')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  #create
  def save
    sql = "INSERT INTO tickets (customer_id, film_id)VALUES($1, $2)RETURNING *"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  #Read
  def Ticket.all()
    sql = "SELECT * FROM tickets"
    ticket_data = SqlRunner.run(sql)
    return ticket.map_items(ticket_data)
  end

  #Delete
  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


  # Returning films and customers
  def film
    sql = "SELECT * FROM films WHERE films.id = $1"
    values = [@film_id]
    film_array = SqlRunner.run(sql, values)
    result= film_array.map{ |film| Film.new(film[0])}
    return film
  end

  def customer
    sql = "SELECT * FROM customers WHERE customers.id = $1"
    values = [@customer_id]
    customer_array = SqlRunner.run(sql, values)
    result = customer_array.map{ |customer|Customer.new(customer[0])  }
    return customer
  end

end
