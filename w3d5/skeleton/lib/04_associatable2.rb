require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = self.assoc_options[through_name]
    define_method(name) do
      source_options = through_options.model_class.assoc_options[source_name]
      query = DBConnection.execute2(<<-SQL)
        SELECT
          #{source_options.table_name}.*
        FROM
          #{through_options.table_name}
        JOIN
          #{source_options.table_name}
          ON
            #{source_options.table_name}.id = #{source_options.foreign_key}
        WHERE
          #{through_options.table_name}.id = #{self.id}
      SQL
      params = query.last
      source_options.class_name.constantize.new(params)
    end
  end
end
