class CatRentalRequest < ActiveRecord::Base
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED) }
  validates :cat_id, :start_date, :end_date, presence: true
  validate :no_approved_request
  after_initialize :set_pending

  belongs_to(
    :cat,
    class_name: :Cat,
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )

  def approve!
    self.class.transaction do      
      overlapping_requests.each do |request|
        request.deny! unless request.id == id
      end
      self.status = "APPROVED"
      self.save
    end
  end

  def deny!
    self.status = "DENIED"
    self.save
  end

  def no_approved_request
    unless overlapping_approved_requests.empty?
      errors[:overlap] << "Conflicting approved requests"
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == "APPROVED" }
  end

  def overlapping_requests
    overlaps = CatRentalRequest.where("cat_id = ? AND (start_date >= ? AND start_date <= ?)
                      OR (end_date >= ? AND end_date <= ?)
                      OR (start_date <= ? AND end_date >= ?)",
                      cat_id, start_date, end_date, start_date, end_date, start_date, end_date)
  end

  def set_pending
    self.status ||= "PENDING"
  end
end
