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

  describe '.visible' do
    let(:visible_birds) { FactoryGirl.create_list(:bird, 3, visible: true) }
    let(:invisible_birds) { FactoryGirl.create_list(:bird, 2, visible: false) }
    before do
      #FIXME For some reason the database cleaner is not cleaning the tables
      Bird.destroy_all
    end
    it 'lists visible birds' do
      expect(Bird.visible).to eq(visible_birds)
      expect(Bird.visible).not_to eq(invisible_birds)
    end
  end
end
