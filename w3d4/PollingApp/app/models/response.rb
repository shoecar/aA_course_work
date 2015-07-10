class Response < ActiveRecord::Base
  validate :respondent_has_not_already_answered_question
  validate :author_can_not_respond_to_own_poll

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    primary_key: :id,
    foreign_key: :answer_id
  )

  belongs_to(
    :respondent,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id
  )

  def author_can_not_respond_to_own_poll
    # debugger
    poll = self.question.poll
    if poll.author == user_id
      errors[:ogawdwhy?] << "Dude, it's YOUR question."
    end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.count > 0
      errors[:answered] << "User already answered this question"
    end
  end

  def sibling_responses
    #abtq is answers_belonging_to_question
    abtq = self.question.responses.select("answer_id")

    Response.where("user_id = ? AND answer_id IN (?)", self.user_id, abtq)
  end
end
