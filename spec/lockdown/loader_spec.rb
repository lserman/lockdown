describe 'loading the inferred resource from the database' do

  let(:controller) { double('controller', params: params) }
  let(:loadable)   { Loadable.new(:test, controller) }
  let(:loader)     { Loader.new(loadable, controller) }

  class Test
    def self.find(*); end
    def self.find_by(*); end
    def self.all(*); end
  end

  context 'singular resource' do
    let(:params) { { id: 1, name: 'test' } }

    it 'resolves to the Test with id 1' do
      expect(Test).to receive(:find) { :test }
      expect(loader.resolve).to eq(:test)
    end

    it 'resolves to the blocks value when a block is given' do
      expect(Test).to_not receive(:find)
      expect(Test).to receive(:find_by).with({ name: 'test' }) { :block }
      expect(loader.resolve { Test.find_by(name: params[:name]) }).to eq(:block)
    end
  end

  context 'collection resource' do
    let(:params) { Hash.new }

    it 'resolves to all of the Test objects' do
      expect(Test).to receive(:all) { :test }
      expect(loader.resolve).to eq(:test)
    end
  end
end

