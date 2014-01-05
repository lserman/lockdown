describe 'making inferences in the Loadable object before the resource is set' do

  let(:controller) { double('controller', params: params) }
  let(:loadable)   { Loadable.new(:test, controller) }

  class Test; end

  context 'singular resource' do
    let(:params) do
      { id: 1 }
    end

    it 'infers the resource is singular' do
      expect(loadable.singular?).to be(true)
    end

    it 'infers the model to be Test' do
      expect(loadable.model).to be(Test)
    end

    it 'infers the instance variable (getter) will be "test"' do
      expect(loadable.getter).to match('test')
    end
  end

  context 'collection resource' do
    let(:params) { Hash.new }

    it 'infers the resource is plural' do
      expect(loadable.singular?).to be(false)
    end

    it 'infers the model to be Test' do
      expect(loadable.model).to be(Test)
    end

    it 'infers the instance variable (getter) will be "tests"' do
      expect(loadable.getter).to match('tests')
    end
  end
end

