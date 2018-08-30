class ApplicationRecord < ActiveRecord::Base
  include Namespaceable
end

module Auth
  class User < ApplicationRecord
    namespace :school do
      has_many :students
      has_many :universities, through: :students

      has_one :current_student, -> { where(status: 'active') }, class_name: 'Student'
      has_one :current_university, through: :current_student, class_name: 'University'
    end
  end
end

module School
  class University < ApplicationRecord
    has_many :students

    namespace :auth do
      has_many :users, through: :students
    end
  end

  class Student < ApplicationRecord
    belongs_to :university

    namespace :auth do
      belongs_to :user
    end
  end
end