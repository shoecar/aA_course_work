require_relative 'questions_module'
require_relative 'save_module'
require_relative 'models'

class Question
  extend QuestionsModule
  include SaveModule

  def self.table_name
    "questions"
  end

  def self.find_by_author_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  attr_accessor :id, :title, :body, :user_id

  def initialize(options = {})
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(user_id)
  end

  def replies
    Reply.find_by_question_id(id)
  end

  def followers
    QuestionFollow.followers_for_question_id(id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLikes.likers_for_question_id(id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question(id)
  end

  def most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end
end

if __FILE__ == $PROGRAM_NAME
  q = Question.find_by_id(1)
  p q.author
  p Question.find_by_author_id(2)
end
