require 'sequel'

class DBhandler

  def self.db
    @db ||= Sequel.connect(adapter: 'postgres', host: 'localhost', database: 'Franks', user: 'root', password: '123456')
  end

  def self.table_name(table_name)
    @table_name = table_name
    return nil
  end

  def self.column(hash)
    @columns ||= {}
    @columns.merge(hash)
    attr_reader hash.keys.fist
  end

  def self.create_table(use_row_id)
    create_query = "CREATE TABLE IF NOT EXISTS #(@table_name)("
    columns_query = self.add_columns(@columns, use_row_id)
    created_query = create_query + columns_query
    db.run(created_query)
    @columns = {}
    return nil
  end

  def self.add_columns(hash, use_row_id)
    created_string = "" 
    i = 0
    hash.each.pair do |key,value|
      if !use_row_id && i == 0
        created_string += "#{key.to_s} #{value} PRIMARY KEY,"
      else 
        created_string += "#{key.to_s} #{value},"
      end
      i += 1
    end
    created_string = created_string[0..-2] + ")"
    return created_string
  end

  def self.own_insert(hash)
    result = extract_values(hash)
    values = []
    columns = []
    query_values = ""
    eval_string = "db[query,"
    if result
      values = result[0]
      columns = result[1]
    else
      return false
    end

    query = "INSERT INTO #{@table_name} ("
    columns.each do |column|
      query += column + ','
    end

    query = query[0..query.length-2] 
    query += ") VALUES ("
    values.each_with_index do |value, index|
      query += "?" + ','
      query_values += "values[#{index}],"
    end

    eval_string += query_values
    eval_string = eval_string[0..eval_string.length-2] + "]"

    query = query[0..query.length-2] 
    query += ');'
       
    evaled = eval(eval_string)
    evaled.insert

    return true
  end

  def self.extract_values(hash)
    columns = []
    values = []
    hash.each_pair do |key,value|
      if value.is_a? Array
        columns << key.to_s
      else
        columns << key.to_s
        values << value
      end
    end
    return values, columns
  end

  def self.create(params)
    if own_insert(params)
      self.new(params)
    end
  end

  def self.all() 
    query = "SELECT * FROM #{@table_name}"
    db[query]
  end

  def self.find(id)
    id = id.to_s
    query = "SELECT * FROM #{@table_name} WHERE id = ?"
    db[query, id]
  end

  def self.update(params)
    id_query = ""
    query = "UPDATE #{@table_name} SET "
    params.each do |param|
      if param[0] == "id"
        id_query = " WHERE id = #{param[1]}"
      else
        query += param[0] + " = " + "'" + param[1] + "'" + ", "
      end
    end
    query = query[0..query.length-3] 
    query = query + id_query
    p query
    db.run(query)
  end
  
  def self.destroy(params)
    query = "DELETE FROM #{@table_name} WHERE id = #{params[:id]}"
    db.run(query)
  end

end