require 'spec_helper'

describe ResourcesController do
  describe '#create' do
    before :each do
      user = FactoryGirl.create(:user)
      yellow_color = FactoryGirl.create(:color, name: 'yellow')
      green_color = FactoryGirl.create(:color, name: 'green')
      party_phase = FactoryGirl.create(:phase, name: 'Party')
      fiesta_phase = FactoryGirl.create(:phase, name: 'Fiesta')

      @description = 'as in tasty carrots'
      @name = 'orange'
      @create_params = {user_id: user.id,
                        color_ids: [yellow_color.id, green_color.id],
                        phase_ids: [party_phase.id, fiesta_phase.id],
                        resource: {
                          name: @name,
                          link: 'resource_link',
                          description: @description,
                          full_description: 'resource_full_description',
                          source: 'A cool person',
                          tag_list: 'resource_tag_list'
                        }
      }
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should create a resource using resource_params' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(Resource.all.count).to eql(1)
        expect(@resource.name).to eql @name
        expect(@resource.link).to eql 'resource_link'
        expect(@resource.description).to eql @description
        expect(@resource.full_description).to eql 'resource_full_description'
        expect(@resource.source).to eql 'A cool person'
        expect(@resource.tag_list).to eql 'resource_tag_list'
      end

      it 'should be able to attach associated colors' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.colors.count).to eql(2)
        expect(@resource.colors.first.name).to eql 'yellow'
        expect(@resource.colors.last.name).to eql 'green'
      end

      it 'should be able to attach associated phases' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.colors.count).to eql(2)
        expect(@resource.phases.first.name).to eql 'Party'
        expect(@resource.phases.last.name).to eql 'Fiesta'
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should create a resource using resource_params' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(Resource.all.count).to eql(1)
        expect(@resource.name).to eql @name
        expect(@resource.link).to eql 'resource_link'
        expect(@resource.description).to eql @description
        expect(@resource.full_description).to eql 'resource_full_description'
        expect(@resource.source).to eql 'A cool person'
        expect(@resource.tag_list).to eql 'resource_tag_list'
      end

      it 'should be able to attach associated colors' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.colors.count).to eql(2)
        expect(@resource.colors.first.name).to eql 'yellow'
        expect(@resource.colors.last.name).to eql 'green'
      end

      it 'should be able to attach associated phases' do
        patch :create, @create_params

        @resource = Resource.all.first

        expect(@resource.colors.count).to eql(2)
        expect(@resource.phases.first.name).to eql 'Party'
        expect(@resource.phases.last.name).to eql 'Fiesta'
      end
    end

    context 'while not signed in' do
      it 'should not be able to create a resource' do
        patch :create, @create_params

        expect(Resource.all.count).to eql(0)
      end
    end
  end

  describe '#destroy' do
    before :each do
      yellow_color = FactoryGirl.create(:color, name: 'yellow')
      green_color = FactoryGirl.create(:color, name: 'green')
      party_phase = FactoryGirl.create(:phase, name: 'Party')
      fiesta_phase = FactoryGirl.create(:phase, name: 'Fiesta')

      @resource = FactoryGirl.create(:resource)
      @resource.colors = [yellow_color, green_color]
      @resource.phases = [party_phase, fiesta_phase]

      @destroy_params = {id: @resource.id}
    end

    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should delete any resource' do
        delete :destroy, @destroy_params

        expect(Resource.all.count).to eql(0)
      end

      it 'should automatically delete color association' do
        @resource.colors.count.should eql(2)

        delete :destroy, @destroy_params

        expect(@resource.colors.count).to eql(0)
      end

      it 'should automatically delete phase association' do
        @resource.phases.count.should eql(2)

        delete :destroy, @destroy_params

        expect(@resource.phases.count).to eql(0)
      end
    end

    context 'as a user' do
      context 'with a resource owned by the user' do
        it 'should delete a resource' do
          # TODO: Allow for UserA to delete a resource UserA owns
          # pending
        end
      end

      context 'with a resource owned by someone else' do
        it 'should not be able to delete a resource' do
          ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
          delete :destroy, @destroy_params

          expect(Resource.all.count).to eql(1)
        end
      end

    end

    context 'while not signed in' do
      it 'should not be able to delete a resource' do
        delete :destroy, @destroy_params

        expect(Resource.all.count).to eql(1)
      end
    end
  end

  describe '#index' do
    before :each do
      resource = FactoryGirl.create(:resource)

      @get_params = {id: resource.id}
    end

    context 'as an admin user' do
      it 'should show the list of resources' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
      end
    end

    context 'as a user' do
      it 'should show the list of resources' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)

        get :index, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resources_path)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#new' do
    context 'as an admin user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
      end

      it 'should view the create-a-resource page' do
        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_resource_path)
      end
    end

    context 'as a user' do
      before :each do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      end

      it 'should view the create-a-resource page' do
        get :new

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(new_resource_path)
      end
    end

    context 'while not signed in' do
      it 'should not view the create-a-resource page' do
        get :new

        response.should redirect_to new_session_path
      end
    end
  end

  describe '#show' do
    before :each do
      @resource = FactoryGirl.create(:resource)

      @get_params = {id: @resource.id}
    end

    context 'as an admin user' do
      it 'should show the requested resource' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)
        controller.stub_chain(:current_user, :id).and_return(1)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'as a user' do
      it 'should show the requested resource' do
        ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
        controller.stub_chain(:current_user, :id).and_return(1)

        get :show, @get_params

        expect(response.status).to be(200)
        expect(controller.request.path).to eql(resource_path)
      end
    end

    context 'while not signed in' do
      it 'should redirect the user to the new sessions path' do
        get :index, @get_params

        response.should redirect_to new_session_path
      end
    end
  end
end