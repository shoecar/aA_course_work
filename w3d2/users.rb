require_relative 'questions_module'
require_relative 'save_module'
require_relative 'models'

class User
  extend QuestionsModule
  include SaveModule

  def self.table_name
    "users"
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    User.new(user.first) unless user.empty?
  end

  attr_accessor :id, :fname, :lname

  def initialize(options = {})
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(id)
  end

  def average_karma
    QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        CAST(COUNT(ql.id) AS FLOAT) / COUNT(DISTINCT(qu.id))
      FROM
        questions qu
      LEFT OUTER JOIN
        question_likes ql ON ql.question_id = qu.id
      -- JOIN
      --   users us ON us.id = qu.user_id
      -- WHERE
      --   us.id = ?
      WHERE
        qu.user_id = ?
    SQL
    .first.values.first
  end
end

if __FILE__ == $PROGRAM_NAME
  t = User.find_by_id(2)
  p t.average_karma
  b = User.find_by_id(5)
  p b.average_karma
end
