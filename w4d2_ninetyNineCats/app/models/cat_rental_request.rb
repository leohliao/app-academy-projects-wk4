# require 'sqlite3'
# require 'singleton'
#
# class DBConnection < SQLite3::Database
#   include Singleton
# end

# class ApplicationRecord < DBConnection
# end


class CatRentalRequest < ApplicationRecord
  validates :status, presence: true, inclusion: %w(PENDING APPROVED DENIED)
  validates :end_date, presence: true
  validates :start_date, presence: true
  validates :cat_id, presence: true
  # validate :does_not_overlap_approved_request

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
          NOT(( start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def approve!
    status
  end

  def deny!
  end

end
