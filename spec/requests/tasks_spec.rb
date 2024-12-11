require 'rails_helper'

RSpec.describe "Admin::TaskController", type: :request do
  fixtures :users
  fixtures :tasks

  describe "GET admin/tasks" do
    it "not allowed without valid cookie" do
      get admin_tasks_path
      expect(response).to have_http_status(401)
    end
  end

  context "when the user is logged in" do
    let(:valid_user) { users(:valid_user) }
    
    before do
      allow_any_instance_of(ApplicationController).to receive(:session).and_return({ user_id: valid_user.id })
    end

    it "retreive all taks only of the current user" do
      get admin_tasks_path
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      body.each do |task|
        expect(task["user_id"]).to eq(valid_user.id)
      end
    end
  end
end