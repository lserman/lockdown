describe 'preloading the controller instance variable' do

  class TestsController
    include Lockdown
    def controller_name; 'tests' end
  end

  let(:controller) { TestsController.new }

  before do
    expect(controller).to receive(:params) { params }
    expect_any_instance_of(Loader).to receive(:resolve) { :test }
  end

  context 'singular resource' do
    let(:params) { { id: 1 } }

    it 'sets the "alias" ivar on the controller' do
      controller.preload(:alias)
      expect(controller.instance_variable_get("@alias")).to be(:test)
    end

    it 'sends the name "test" to Loadable even if its not specified; inferred from the controller class' do
      expect(Loadable).to receive(:new).with('test', controller).and_call_original
      controller.preload
      expect(controller.instance_variable_get("@test")).to be(:test)
    end
  end

  context 'collection resource' do
    let(:params) { Hash.new }

    it 'sets the "tests" ivar on the controller' do
      controller.preload(:test)
      expect(controller.instance_variable_get("@tests")).to be(:test)
    end
  end

end