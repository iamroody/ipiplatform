require 'spec_helper'

describe StepsController do

 let(:valid_attributes) { { name: "MyString" } }
 let(:valid_attributes_with_vp_id) { { name: "MyString", value_proposition_id: 0 } }

 let(:mock_step) { mock_model(Step, id:"0", name: "stepName", journey_id: "0")}
 let(:mock_journey) { mock_model(Journey, title: "JourneyTitle", value_proposition_id: "0")}
 let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all steps as @steps" do
      step = Step.create! valid_attributes
      get :index, {}, valid_session
      assigns(:steps).should eq([step])
    end
  end

  describe "GET show" do
    it "assigns the requested step as @step" do
      step = Step.create! valid_attributes
      get :show, {:id => step.to_param}, valid_session
      assigns(:step).should eq(step)
    end
  end

  describe "GET new" do
    it "assigns a new step as @step" do
      pending("")
      get :new, {value_proposition_id: 0}, valid_session
      assigns(:step).should be_a_new(Step)
    end
    it "assigns the value proposition id of the step as @value_proposition_id" do
      pending("")
      get :new, {value_proposition_id: 0}, valid_session
      assigns(:value_proposition_id).should == "0"
    end
  end

  describe "GET new v2" do
    it "loads a new step" do
      Step.should_receive(:new)
      get :new, {journey_id: "0"}
    end

    it "assigns @step to new step" do
      get :new, { journey_id: "0"}
      assigns(:step).should eq mock_step
    end

    it "loads the journey id" do
      get :new, { journey_id: "0"}
      assigns(:journey_id).should eq "0"
    end
  end

  describe "GET edit" do
    it "assigns the requested step as @step" do
      step = Step.create! valid_attributes
      get :edit, {:id => step.to_param}, valid_session
      assigns(:step).should eq(step)
    end

    it 'should assign resources ordered by position' do
      ApplicationController.any_instance.stub(:redirect_if_not_signed_in).and_return(nil)
      ApplicationController.any_instance.stub(:redirect_if_unauthorized).and_return(nil)

      mock_resources = [double(Resource)]
      mock_resources.should_receive(:order).with(:position).and_return(mock_resources)
      mock_step = double(Step)
      mock_step.stub(:resources).and_return(mock_resources)
      mock_step.stub(:value_proposition_id)
      Step.stub(:find).and_return(mock_step)

      get :edit, { :id => 0 }

      assigns(:resources).should eql mock_resources
    end

    it "assigns the value proposition id of the step as @value_proposition_id" do
      mock_resources = [double(Resource)]
      mock_resources.should_receive(:order).with(:position).and_return(mock_resources)
      mock_step = double(Step)
      mock_step.stub(:resources).and_return(mock_resources)
      mock_step.stub(:value_proposition_id).and_return(1)
      Step.stub(:find).and_return(mock_step)

      get :edit, {id: 0}, valid_session

      assigns(:value_proposition_id).should == 1
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Step" do
        expect {
          post :create, {:step => valid_attributes}, valid_session
        }.to change(Step, :count).by(1)
      end

      it "assigns a newly created step as @step" do
        post :create, {:step => valid_attributes}, valid_session
        assigns(:step).should be_a(Step)
        assigns(:step).should be_persisted
      end

      it "redirects to edit value proposition" do
        pending("old step test")
        mock_step = double(Step)
        mock_step.stub(:save).and_return(true)
        Step.stub(:new).and_return(mock_step)

        post :create, {:step => valid_attributes_with_vp_id}, valid_session
        response.should redirect_to(edit_value_proposition_path(valid_attributes_with_vp_id[:value_proposition_id]))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved step as @step" do
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        post :create, {:step => { "name" => "invalid value" }}, valid_session
        assigns(:step).should be_a_new(Step)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        post :create, {:step => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested step" do
        step = Step.create! valid_attributes
        # Assuming there are no other steps in the database, this
        # specifies that the Step created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Step.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => step.to_param, :step => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested step as @step" do
        step = Step.create! valid_attributes

        put :update, {:id => step.to_param, :step => valid_attributes}, valid_session
        assigns(:step).should eq(step)
      end

      it "assigns resources for invalid parms" do
        step = Step.create! valid_attributes
        resource1 = FactoryGirl.create(:resource, name: "Resource1")
        step.resources= [resource1]
        step.save

        put :update, {:id => step.to_param, :step => { "name" => ""}}, valid_session
        assigns(:step).should eq(step)
        assigns(:resources).should =~ [resource1]

      end

      it "redirects to edit value proposition" do
        pending("")
        mock_step = double(Step)
        mock_step.stub(:update).and_return(true)
        Step.stub(:find).and_return(mock_step)

        put :update, {:id => 0, :step => valid_attributes_with_vp_id}, valid_session
        response.should redirect_to(edit_value_proposition_path(valid_attributes_with_vp_id[:value_proposition_id]))
      end
    end

    describe "with invalid params" do
      it "assigns the step as @step" do
        step = Step.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        put :update, {:id => step.to_param, :step => { "name" => "invalid value" }}, valid_session
        assigns(:step).should eq(step)
      end

      it "re-renders the 'edit' template" do
        step = Step.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Step.any_instance.stub(:save).and_return(false)
        put :update, {:id => step.to_param, :step => { "name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested step" do
      step = Step.create! valid_attributes
      expect {
        delete :destroy, {:id => step.to_param}, valid_session
      }.to change(Step, :count).by(-1)
    end

    it "redirects to edit value proposition" do
      mock_step = stub_model(Step, value_proposition_id: 1)
      mock_step.stub(:destroy)
      Step.stub(:find).and_return(mock_step)
      delete :destroy, {:id => 0}, valid_session
      response.should redirect_to(edit_value_proposition_path(mock_step.value_proposition_id))
    end
  end

  describe 'GET edit' do
    it 'assigns resources' do
      step = FactoryGirl.create(:step)
      resource1 = FactoryGirl.create(:resource, name: "Resource1")
      resource2 = FactoryGirl.create(:resource, name: "Resource2")
      step.resources = [resource1, resource2]
      step.save

      get :edit, {id: step.id}

      assigns(:resources).should =~([resource1, resource2])
    end
  end

  describe 'GET reorder' do
    before :each do
      @mock_value_proposition = double(:value_proposition)
      ValueProposition.stub(:find).and_return(@mock_value_proposition)
      @mock_steps = [double(:step)]
      @mock_value_proposition.stub(:steps).and_return(@mock_steps)
    end

    it "assigns the value proposition id as @value_proposition_id" do
      @mock_steps.stub(:order)
      get :reorder, {value_proposition_id: 0}
      assigns(:value_proposition_id).should == "0"
    end

    it 'should assign steps ordered by position' do
      @mock_steps.should_receive(:order).with(:position).and_return(@mock_steps)

      get :reorder, {value_proposition_id: 0}

      assigns(:steps).should eql @mock_steps
    end
  end

  describe "POST sort" do
    it 'should make a call to sort on sorter ' do
      StepsSorter.any_instance.should_receive(:sort).and_return(nil)

      post :sort, {step: [6,5,7]}
    end
  end
end
