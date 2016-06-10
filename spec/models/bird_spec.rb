require 'rails_helper'

RSpec.describe Bird, type: :model do
  it 'exists' do
    expect { Bird }.not_to raise_error
  end

  describe 'attributes' do
    let(:bird) { FactoryGirl.build(:bird) }
    it 'has name' do
      expect(bird.attributes).to include('name')
    end
    it 'has family' do
      expect(bird.attributes).to include('family')
    end
    it 'has continents' do
      expect(bird.attributes).to include('continents')
    end
    it 'has added' do
      expect(bird.attributes).to include('added')
    end
    it 'has visible' do
      expect(bird.attributes).to include('visible')
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      bird = FactoryGirl.build(:bird, name: nil)
      bird.valid?
      expect(bird.errors).to include(:name)
    end
    it 'validates presence of family' do
      bird = FactoryGirl.build(:bird, family: nil)
      bird.valid?
      expect(bird.errors).to include(:family)
    end
    it 'validates presence of continents' do
      bird = FactoryGirl.build(:bird, continents: nil)
      bird.valid?
      expect(bird.errors).to include(:continents)
    end
  end
end
