require_relative 'questions_module'
require_relative 'save_module'
require_relative 'models'

class QuestionFollow
  extend QuestionsModule
  include SaveModule

  def self.table_name
    'question_follows'
  end

  def self.followers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        question_follows q
      JOIN
        users u ON q.user_id = u.id
      WHERE
        q.question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        qu.*
      FROM
        question_follows q
      JOIN
        questions qu ON q.question_id = qu.id
      WHERE
        q.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        qu.*
      FROM
        question_follows qufo
      JOIN
        questions qu ON qu.id = qufo.question_id
      GROUP BY
        qu.title
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end

if __FILE__ == $PROGRAM_NAME
  p QuestionFollow.most_followed_questions(2)
end
