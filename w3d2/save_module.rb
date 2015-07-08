module SaveModule

  def save
    if id.nil?
      insert
      @id = self.class.row_count
    else
      raise "Bad id" if self.class.row_count < id

      update
    end
  end

  private
  
  def insert
    QuestionsDatabase.instance.execute(<<-SQL)
      INSERT INTO
        #{self.class.table_name} #{insert_columns}
      VALUES
        #{insert_values}
    SQL
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_values}
      WHERE
        id = ?
    SQL
  end

  def insert_columns
    "(#{self.instance_variables.drop(1).map { |sym| sym.to_s[1..-1] }.join(", ")})"
  end

  def insert_values
    string = self.instance_variables.drop(1).map do |sym|
      string_to_value(sym.to_s)
    end.join(", ")
    "(#{string})"
  end

  def set_values
    self.instance_variables.drop(1).each_with_object([]) do |sym, arr|
      string = ''
      string << sym.to_s[1..-1] + ' = '
      string << string_to_value(sym.to_s)
      arr << string
    end.join(', ')
  end

  def string_to_value(string)
    value = self.instance_eval(string)

    if value.is_a?(Integer)
      value.to_s
    else
      "\"#{value}\""
    end
  end
end
