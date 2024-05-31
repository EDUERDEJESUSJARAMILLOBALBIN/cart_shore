require 'rails_helper'

RSpec.describe OrderablesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @orderables, @orderables_grouped_by_order, @order_totals and @total_all_orders" do
      orderable = create(:orderable, order_created: true, session_id: session.id.to_s)
      get :index
      expect(assigns(:orderables)).to include(orderable)
      expect(assigns(:orderables_grouped_by_order)).not_to be_nil
      expect(assigns(:order_totals)).not_to be_nil
      expect(assigns(:total_all_orders)).not_to be_nil
    end
  end

  describe "POST #create_order" do
    it "redirects to orderables_path" do
      cart = create(:cart)
      allow(controller).to receive(:generate_order_code).and_return("ABC123")
      session[:cart_id] = cart.id
      post :create_order
      expect(response).to redirect_to(orderables_path)
    end

    it "creates orders for cart items" do
      cart = create(:cart)
      orderable = create(:orderable, cart: cart, order_created: false)
      session[:cart_id] = cart.id
      allow(controller).to receive(:generate_order_code).and_return("ABC123")
      expect {
        post :create_order
      }.to change { Orderable.where(order_created: true).count }.by(1)
    end
  end

  describe "DELETE #delete_order" do
    it "redirects to orderables_path" do
      orderable = create(:orderable)
      delete :delete_order, params: { order_code: orderable.code_order }
      expect(response).to redirect_to(orderables_path)
    end
  end
end
