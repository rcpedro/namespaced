require 'spec_helper'

describe Namespaced do
  it 'has a version number' do
    expect(Namespaced::VERSION).not_to be nil
  end

  describe Auth::User do
    subject { Auth::User }

    describe 'students' do
      let (:students) { subject.reflect_on_association(:students) }

      it { expect(students).to       be_present }
      it { expect(students.klass).to eq(School::Student) }
      it { expect(students.class).to eq(ActiveRecord::Reflection::HasManyReflection) }
    end

    describe 'universities' do
      let (:universities) { subject.reflect_on_association(:universities) }

      it { expect(universities).to       be_present }
      it { expect(universities.klass).to eq(School::University) }
      it { expect(universities.class).to eq(ActiveRecord::Reflection::ThroughReflection) }
    end

    describe 'current student' do
      let (:student) { subject.reflect_on_association(:current_student) }

      it { expect(student).to       be_present }
      it { expect(student.klass).to eq(School::Student) }
      it { expect(student.class).to eq(ActiveRecord::Reflection::HasOneReflection) }
    end

    describe 'current university' do
      let (:university) { subject.reflect_on_association(:current_university) }

      it { expect(university).to       be_present }
      it { expect(university.klass).to eq(School::University) }
      it { expect(university.class).to eq(ActiveRecord::Reflection::ThroughReflection) }
    end
  end

  describe School::Student do
    subject { School::Student }

    describe 'university' do
      let (:university) { subject.reflect_on_association(:university) }

      it { expect(university).to       be_present }
      it { expect(university.klass).to eq(School::University) }
      it { expect(university.class).to eq(ActiveRecord::Reflection::BelongsToReflection) }
    end

    describe 'user' do
      let (:user) { subject.reflect_on_association(:user) }

      it { expect(user).to       be_present }
      it { expect(user.klass).to eq(Auth::User) }
      it { expect(user.class).to eq(ActiveRecord::Reflection::BelongsToReflection) }
    end
  end
end
