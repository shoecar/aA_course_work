require_relative 'questions_module'
require_relative 'save_module'
require_relative 'models'

class Reply
  extend QuestionsModule
  include SaveModule

  def self.table_name
    "replies"
  end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end

  attr_accessor :id, :user_id, :question_id, :reply_id, :body

  def initialize(options = {})
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @reply_id = options['reply_id']
    @body = options['body']
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    return nil unless reply_id
    Reply.find_by_id(reply_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        reply_id = ?
    SQL

    replies.map { |reply| Reply.new(reply) }
  end
end

if __FILE__ == $PROGRAM_NAME
  p r = Reply.find_by_id(1)
  p r.parent_reply
  p r.child_replies
end
