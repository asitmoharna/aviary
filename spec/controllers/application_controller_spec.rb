require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#handle_exception' do
    context 'when the mongo record is not found' do
      controller do
        def index
          handle_exception do
            raise Mongoid::Errors::DocumentNotFound.new(Bird, id: 1)
          end
        end
      end
      it 'sends a 404 response' do
        get :index
        expect(response.code).to eq('404')
      end
    end
    context 'when argument error occurs' do
      controller do
        def index
          handle_exception do
            raise ArgumentError.new('Some invalid argument')
          end
        end
      end
      it 'sends a 422 response' do
        get :index
        expect(response.code).to eq('422')
      end
    end
    context 'when standard error occurs' do
      controller do
        def index
          handle_exception do
            raise 'Something went wrong'
          end
        end
      end
      it 'sends a 500 response' do
        get :index
        expect(response.code).to eq('500')
      end
    end
  end
end
