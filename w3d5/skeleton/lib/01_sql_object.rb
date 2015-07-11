require_relative 'db_connection'
require 'byebug'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    query = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    query.first.map { |col| col.to_sym }
  end

  def self.finalize!
    columns.each do |col|
      # debugger
      define_method(col) { attributes[col] }
      define_method("#{col}=") do |arg|
        attributes[col] = arg
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= to_s.tableize
  end

  def self.all
    query = DBConnection.execute2(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(query.drop(1))
  end

  def self.parse_all(results)
    cats = []
    results.each do |object|
      cats << new(object)
    end
    cats
  end

  def self.find(id)
    query = DBConnection.execute2(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        id = #{id}
    SQL
    if query.count > 1
      new(query[1])
    else
      nil
    end
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      unless self.class.columns.include?(attr_name)
        raise "unknown attribute '#{attr_name}'"
      else
        send("#{attr_name}=", value)
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |method| send(method) }
  end

  def insert
    n = self.class.columns.drop(1)
    col_names = n.join(", ")
    question_marks = (["?"] * n.count).join(", ")

    query = DBConnection.execute2(<<-SQL, *attribute_values.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.drop(1).map { |attr_name| "#{attr_name} = ?" }.join(", ")

    query = DBConnection.execute2(<<-SQL, *attribute_values.drop(1), self.id)
    UPDATE
      #{self.class.table_name}
    SET
      #{set_line}
    WHERE
      id = ?
    SQL


  end

  def save
    if self.id
      update
    else
      insert
    end
  end
end
