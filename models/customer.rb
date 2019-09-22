require_relative('../db/sql_runner')
require_relative('./film')
require_relative('./ticket')



class Customer

  attr_reader :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
  end

# setup CRUD
# Create
  def save()
    sql = "INSERT INTO customers(name,funds) VALUES($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

# Read
  def self.all()
    sql = "SELECT * FROM customers"
    customer_array = SqlRunner.run(sql)
    result = customer_array.map { |customer| Customer.new( customer ) }
    return result
  end

# update
  def update
    sql = "UPDATE customers SET funds = $1, name = $2 WHERE id = $3"
    values = [@funds, @name, @id]
    SqlRunner.run(sql, values)
  end

# Delete
  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

# Return the films for a customer
  def films()
      sql = "SELECT films.* FROM films
      INNER JOIN tickets ON tickets.film_id = films.id
      WHERE tickets.customer_id = $1"
      values = [@id]
      film_array = SqlRunner.run(sql, values)
      result = film_array.map { |film| Film.new( film ) }
      return result
    end

#decrease funds when ticket bought
    def buy_ticket(ticket)
      if @funds >= ticket.price
        @funds -= ticket.price
      else
        return "not enough funds"
      end
  end
end
