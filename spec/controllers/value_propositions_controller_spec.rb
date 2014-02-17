require 'spec_helper'

describe ValuePropositionsController do
  describe '#create' do
    before :each do
      @description = 'as in tasty carrots'
      @name = 'orange'
      @value_proposition_category = FactoryGirl.create(:value_proposition_category, name: 'Hats and bowties', description: 'are good for events')
      @create_params = { value_proposition: {
                                name: @name,
                                description: @description,
                                },
                         value_proposition_category_id: @value_proposition_category.id
                        }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ValuePropositionCategory.stub(:find).and_return(@value_proposition_category)
      end

      it 'should create a value proposition' do
        patch :create, @create_params

        @value_proposition = ValueProposition.all.first

        expect(@value_proposition.name).to eql 'orange'
        expect(@value_proposition.description).to eql @description
      end

      it 'should be able to attach associated value proposition category' do
        ValuePropositionCategory.should_receive(:find).exactly(1).times

        patch :create, @create_params
      end
    end

    context 'as a user' do
      it 'should not be able to create a value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :create, @create_params

        expect(ValueProposition.all.count).to eql(0)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        patch :create, @create_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to create a value proposition' do
        patch :create, @create_params

        expect(ValueProposition.all.count).to eql(0)
      end
    end
  end

  describe '#destroy' do
    before :each do
      @value_proposition_category = FactoryGirl.create(:value_proposition_category)
      value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: @value_proposition_category)
      @destroy_params = {id: value_proposition.id}
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should delete a value proposition' do
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(0)
      end

      it 'should be able to detatch associated value proposition category' do
        @value_proposition_category.value_propositions.count.should eql(1)

        delete :destroy, @destroy_params

        expect(@value_proposition_category.value_propositions.count).to eql(0)
      end
    end

    context 'as a user' do
      it 'should not be able to delete a value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(1)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        delete :destroy, @destroy_params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to delete a value proposition' do
        delete :destroy, @destroy_params

        expect(ValueProposition.all.count).to eql(1)
      end
    end
  end

  describe '#index' do
    before :each do
      value_proposition_category = FactoryGirl.create(:value_proposition_category)
      value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: value_proposition_category)
      @get_params = {id: value_proposition.id}
    end

    context 'as an admin user' do
      it 'should show the list of value propositions' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_propositions_path)
      end
    end

    context 'as a user' do
      it 'should redirect the user to the root path' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        get :index, @get_params

        response.should redirect_to root_path
      end
    end

    context 'while not signed in' do
      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#show' do
    before :each do
      value_proposition_category = FactoryGirl.create(:value_proposition_category)
     @value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: value_proposition_category)
      @get_params = {id: @value_proposition.id}
    end

    context 'as an admin user' do
      it 'should show the requested value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
      it 'should assign steps and resource' do
        step = FactoryGirl.create(:step, value_proposition: @value_proposition)
        resource1 = FactoryGirl.create(:resource, step: step)
        resource2 = FactoryGirl.create(:resource, name: 'resource2', step: step)
        get :show, @get_params

        assigns(:value_proposition).steps =~ [step]
        assigns(:value_proposition).steps.first.resources =~ [resource1, resource2]

      end
    end

    context 'as a user' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end

    context 'while not signed in' do
      it 'should show the requested value proposition' do
        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(value_proposition_path)
      end
    end
  end

  describe '#update' do
    before :each do
      @description = 'as in tasty carrots'
      @name = 'orange'
      @other_value_proposition_category = FactoryGirl.create(:value_proposition_category, name: 'Hats and bowties', description: 'are good for events')
      @value_proposition = FactoryGirl.create(:value_proposition, value_proposition_category: FactoryGirl.create(:value_proposition_category))
      @params = {id: @value_proposition.id,
                 value_proposition: {
                   name: @name,
                   description: @description,
                 },
                 value_proposition_category_id: @other_value_proposition_category.id
      }
    end
    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        ValuePropositionCategory.stub(:find).and_return(@other_value_proposition_category)
      end

      it 'should update value propositions' do
        patch :update, @params

        @value_proposition.reload

        expect(@value_proposition.name).to eql 'orange'
        expect(@value_proposition.description).to eql @description
      end

      it 'should be able to replace associated value proposition category' do
        ValuePropositionCategory.should_receive(:find).exactly(1).times

        patch :update, @params
      end
    end

    context 'as a user' do
      it 'should not be able to update a value proposition' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        patch :update, @params

        @value_proposition.reload

        expect(@value_proposition.name).to eql('value_proposition_name')
        expect(@value_proposition.description).to eql('value_proposition_description')
      end
    end

    context 'while not signed in' do
      it 'should redirect the user' do
        patch :update, @params

        expect(response.status).to be(302)
        response.should redirect_to new_session_path
      end

      it 'should not be able to update a value proposition' do
        patch :update, @params

        @value_proposition.reload

        expect(@value_proposition.name).to eql('value_proposition_name')
        expect(@value_proposition.description).to eql('value_proposition_description')
      end
    end
  end

  describe "GET edit" do
    it "as admin should assign steps for value proposition as @steps" do
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

      mock_value_proposition = double(ValueProposition)
      ValueProposition.stub(:find).and_return(mock_value_proposition)
      mock_steps = [double(Step)]
      mock_value_proposition.stub(:steps).and_return(mock_steps)

      get :edit, { :id => 0 }

      assigns(:steps).should == mock_steps
    end
  end
end
