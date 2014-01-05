describe 'preloading the controller instance variable' do

  class Controller
    include Lockdown
    def params; { id: 1 } end
  end

  let(:controller) { Controller.new }

  before do
    expect(controller).to receive(:params) { params }
    expect_any_instance_of(Loader).to receive(:resolve) { :test }
  end

  context 'singular resource' do
    let(:params) do
      { id: 1 }
    end

    it 'sets the "test" ivar on the controller' do
      controller.preload(:test, {})
      expect(controller.instance_variable_get("@test")).to be(:test)
    end
  end

  context 'collection resource' do
    let(:params) { Hash.new }

    it 'sets the "tests" ivar on the controller' do
      controller.preload(:test, {})
      expect(controller.instance_variable_get("@tests")).to be(:test)
    end
  end

end