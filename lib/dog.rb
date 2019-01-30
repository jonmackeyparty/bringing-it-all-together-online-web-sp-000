class Dog 
  attr_accessor :id, :name, :breed 
  
  def initialize(id: nil, name:, breed:)
    @name=name
    @breed=breed
  end 
  
  def self.create_table 
    sql=<<-SQL 
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
      SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table 
     DB[:conn].execute("DROP TABLE dogs")
  end
  
  def save 
     sql=<<-SQL 
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
      SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end
  
  def self.create(attribute_hash)
    dog=Dog.new(name: attribute_hash[:name], breed: attribute_hash[:breed])
    dog.save
    dog
  end
  
  def self.find_by_id(id)
    sql=<<-SQL
      SELECT * FROM dogs 
      WHERE ID = ? 
    SQL
    
    dog_array = DB[:conn].execute(sql, id)[0]
    dog=self.new(id: id, name: dog_array[0], breed: dog_array[1])
    dog
  end
    
    

end
    