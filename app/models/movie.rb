class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations
  has_many :genres, through: :characterizations

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where('released_on < ?', Time.now).order('released_on desc') }
  scope :upcoming, -> { where('released_on > ?', Time.now).order('released_on asc') }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :hits, -> { released.where('total_gross >= 300000000').order(total_gross: :desc) }
  scope :flops, -> { released.where('total_gross < 300000000').order(total_gross: :asc) }
  scope :grossed_less_than, ->(amount) { released.where('total_gross < ?', amount).order('total_gross desc') }
  scope :grossed_greater_than, ->(amount) { released.where('total_gross > ?', amount).order('total_gross asc') }

  def flop?
    return if reviews.count >= 50 && average_stars >= 4

    (total_gross.blank? || total_gross < 225_000_000)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = "#{id}-#{title.parameterize}"
  end
end
