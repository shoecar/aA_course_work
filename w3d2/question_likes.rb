require_relative 'questions_module'
require_relative 'save_module'
require_relative 'models'

class QuestionLikes
  extend QuestionsModule
  include SaveModule

  def self.table_name
    'question_likes'
  end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        question_likes ql
      JOIN
        users u ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
    SQL

    users.map { |user| User.new(user) }
  end

  def self.num_likes_for_question(question_id)
    QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) likes
      FROM
        question_likes
      WHERE
        question_id = ?
      GROUP BY
        question_id
    SQL
    .first['likes']
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        qu.*
      FROM
        questions qu
      JOIN
        question_likes quli ON quli.question_id = qu.id
      WHERE
        quli.user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        qu.*
      FROM
        question_likes quli
      JOIN
        questions qu ON qu.id = quli.question_id
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
  p QuestionLikes.most_liked_questions(2)
end
