require 'spec_helper'

describe ColorsController do
  before :each do
    @description = 'as in tasty carrots'
    @name = 'orange'
  end

  describe '#update' do
    before :each do
      other_value_proposition = FactoryGirl.create(:value_proposition, name: 'Hats and bowties', description: 'are good for events')
      @color = FactoryGirl.create(:color, value_proposition: FactoryGirl.create(:value_proposition))
      @params = {id: @color.id,
                 color: {
                   name: @name,
                   description: @description,
                 },
                 value_proposition_id: other_value_proposition.id
      }
    end
    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should update colors' do
        patch :update, @params

        @color.reload

        expect(@color.name).to eql 'orange'
        expect(@color.description).to eql @description
      end

      it 'should be able to replace associated value proposition' do
        patch :update, @params

        @color.reload

        expect(@color.value_proposition.name).to eql 'Hats and bowties'
        expect(@color.value_proposition.description).to eql 'are good for events'
      end
    end

    context 'as a user' do
      it 'should not be able to update a color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :update, @params

        @color.reload

        expect(@color.name).to eql('color_name')
        expect(@color.description).to eql('color_description')
      end
    end

    context 'while not signed in' do
      it 'should not be able to update a color' do
        patch :update, @params

        @color.reload

        expect(@color.name).to eql('color_name')
        expect(@color.description).to eql('color_description')
      end
    end
  end

  describe '#create' do
    before :each do
      value_proposition = FactoryGirl.create(:value_proposition, name: 'Hats and bowties', description: 'are good for events')
      @create_params = {color: {
        name: @name,
        description: @description,
      },
                        value_proposition_id: value_proposition.id
      }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create a color' do
        patch :create, @create_params

        @color = Color.all.first

        expect(@color.name).to eql 'orange'
        expect(@color.description).to eql @description
      end

      it 'should be able to attach associated value proposition' do
        patch :create, @create_params

        @color = Color.all.first

        expect(@color.value_proposition.name).to eql 'Hats and bowties'
        expect(@color.value_proposition.description).to eql 'are good for events'
      end
    end

    context 'as a user' do
      it 'should not be able to create a color' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :create, @create_params

        expect(Color.all.count).to eql(0)
      end
    end

    context 'while not signed in' do
      it 'should not be able to create a color' do
        patch :create, @create_params

        expect(Color.all.count).to eql(0)
      end
    end
  end
end