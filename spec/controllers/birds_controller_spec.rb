require 'rails_helper'

RSpec.describe BirdsController, type: :controller do
  describe '#index' do
    before do
      #FIXME For some reason the database cleaner is not cleaning the database
      Bird.destroy_all
    end
    context 'when there is no birds present' do
      it 'returns a success response with empty array' do
        get :index
        response_body = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(response_body).to eq([])
      end
    end
    context 'when there are both visible and invisible birds present' do
      before do
        FactoryGirl.create(:bird, visible: true, id: '123')
        FactoryGirl.create(:bird, visible: true, id: '234')
        FactoryGirl.create(:bird, visible: false, id: '345')
      end
      it 'returns a success response with only visible birds ids' do
        get :index
        response_body = JSON.parse(response.body)
        expect(response.code).to eq('200')
        expect(response_body).to eq(['123', '234'])
      end
    end
  end
end
