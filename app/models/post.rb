class Post < ApplicationRecord
    validate :title, presence: true
    validate :content, length {minimum: 250}
    validate :summary, length {maximum: 500}
    validates :category, inclusion: { in: %w(fiction nonfiction),
    message: "%{value} not a category" }
    
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction'] }
    validate :clickbait?
  
    CLICKBAIT_PATTERNS = [
      /Won't Believe/i,
      /Secret/i,
      /Top \d/i,
      /Guess/i
    ]
  
    def clickbait?
      if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
        errors.add(:title, "must be clickbait")
      end
    end

end
