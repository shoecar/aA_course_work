class Cat < ActiveRecord::Base
  validates :color, inclusion: { in: %w(black calico grey white) }
  validates :sex, inclusion: { in: %w(M F) }
  validates :name, presence: true

  has_many(
    :rental_requests,
    class_name: :CatRentalRequest,
    foreign_key: :cat_id,
    primary_key: :id
  )

  def age

    if birth_date.nil?
      return 0
    else
      now = Date.today
      age = (now - birth_date) / 365
      age.to_i
    end
  end
end
