class Question < ActiveRecord::Base

  belongs_to(
    :poll,
    class_name: :Poll,
    primary_key: :id,
    foreign_key: :poll_id
  )

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :question_id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    things = {}
    answers = answer_choices.includes(:responses)
    answers.each_with_index do |answer, i|
      things[answer.text] = answer.responses.count
    end

    things
    # Question.find_by_sql(<<-SQL, bob: self.id).count
    #   SELECT answer_choices.text, COUNT(responses.id)
    #   FROM questions
    #   JOIN answer_choices
    #     ON answer_choices.question_id = questions.id
    #   JOIN responses
    #     ON responses.answer_id = answer_choices.id
    #   WHERE answer_choices.question_id = :bob
    #   GROUP BY answer_choices.id
    # SQL
  end
end
