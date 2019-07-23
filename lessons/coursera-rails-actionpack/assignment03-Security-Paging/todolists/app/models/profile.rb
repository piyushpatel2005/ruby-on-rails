class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { in: %w(male female), message: "%{value} must be male or female"}
  validate :first_or_last_required
  validate :first_name_sue_male_invalid

  def first_or_last_required
    if(first_name.nil? && last_name.nil?)
      errors.add(:first_name, "Provide at least first name or last name.")
    end
  end

  def first_name_sue_male_invalid
    if(gender == "male" && first_name == "Sue")
      errors.add(:first_name, "Male with first name 'Sue' not allowed.")
    end
  end

  # class method as it has to get all profile and not specific instance
  def self.get_all_profiles(min_birth_year, max_birth_year)
    Profile.where(birth_year: min_birth_year..max_birth_year).order(:birth_year)
  end
end
