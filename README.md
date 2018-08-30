# Namespaced

Declare ActiveRecord relations under namespaces for projects where models are segragated by feature.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'namespaced'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install namespaced

## Usage

Include the concern Namespaceable to your ActiveRecord models:

```
class ApplicationRecord < ActiveRecord::Base
  include Namespaceable
end
```

Declare namespaces for associations:

```
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
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rcpedro/namespaced.

