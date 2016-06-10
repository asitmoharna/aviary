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
    describe '#unique_continents' do
      context 'when continents are not given' do
        it 'raises validation error' do
          bird = FactoryGirl.build(:bird, continents: nil)
          bird.valid?
          expect(bird.errors).to include(:continents)
        end
      end
      context 'when continents are given' do
        context 'when continents are not unique' do
          it 'raises validation error' do
            bird = FactoryGirl.build(:bird, continents: ['Asia', 'Africa', 'Asia'])
            bird.valid?
            expect(bird.errors).to include(:continents)
          end
        end
        context 'when continents are unique' do
          it 'does not raise any validation error' do
            bird = FactoryGirl.build(:bird, continents: ['Asia', 'Africa'])
            bird.valid?
            expect(bird.errors).not_to include(:continents)
          end
        end
      end
    end
    describe '#added_date_format' do
      context 'when added is not given' do
        it 'sets today value by default' do
          bird = FactoryGirl.build(:bird)
          bird.valid?
          expect(bird.added).not_to be_nil
          expect(bird.errors).not_to include(:added)
        end
      end
      context 'when added is given' do
        context 'when added is nil' do
          it 'raises validation error' do
            bird = FactoryGirl.build(:bird, added: nil)
            bird.valid?
            expect(bird.errors).to include(:added)
          end
        end
        context 'when added is not valid' do
          it 'raises error' do
            bird = FactoryGirl.build(:bird, added: '2015-02-29')
            bird.valid?
            expect(bird.errors).to include(:added)
          end
        end
        context 'when added is valid' do
          it 'doesnot raise any error' do
            bird = FactoryGirl.build(:bird, added: '2015-02-28')
            bird.valid?
            expect(bird.errors).not_to include(:added)
          end
        end
      end
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
