require 'rails_helper'

RSpec.describe BirdsController, type: :controller do
  before do
    #FIXME For some reason the database cleaner is not cleaning the database
    Bird.destroy_all
  end
  describe '#index' do
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
  describe '#create' do
    context 'when validation fails' do
      it 'returns bad request error with status code 400' do
        post :create
        expect(response.code).to eq('400')
      end
    end
    context 'when data is valid' do
      before do
        time_now = Time.parse('2016-01-01 00:00:00 UTC')
        expect(Time.zone).to receive(:now).and_return(time_now)
      end
      it 'returns 201 response' do
        post :create, name: 'Pigeon', family: 'Columba', continents: ['Asia']
        response_body = JSON.parse(response.body)
        expect(response.code).to eq('201')
        expect(response_body['id']).not_to be_nil
        expect(response_body['name']).to eq('Pigeon')
        expect(response_body['family']).to eq('Columba')
        expect(response_body['continents']).to eq(['Asia'])
        expect(response_body['visible']).to eq(false)
        expect(response_body['added']).to eq('2016-01-01')
      end
    end
  end
end
