require_relative 'question_db'

module QuestionsModule
  def find_by_id(id)
    hash = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL

    self.new(hash.first)
  end

  def all
    rows = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    rows.map { |row| self.new(row) }
  end

  def row_count
    QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        COUNT(*)
      FROM
        #{table_name}
    SQL
    .first.values.first
  end
end
