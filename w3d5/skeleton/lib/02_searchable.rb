require_relative 'db_connection'
require_relative '01_sql_object'
require 'active_support/inflector'

module Searchable
  def where(params)
    where_line = params.map { |key, _| "#{key} = ?" }.join(" AND ")

    query = DBConnection.execute2(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    if query.drop(1).count == 0
      return []
    else
      query.drop(1).map { |h| new(h) }
    end
  end
end

class SQLObject
  extend Searchable
end
