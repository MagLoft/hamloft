require 'hamloft'
RSpec.describe Hamloft do
  it 'renders a custom hamloft widget' do
    require_relative 'fixtures/widget/sample.rb'
    Hamloft.register_widget(SampleWidget)
    haml = File.read('spec/fixtures/test.haml')
    results = Hamloft.render(haml, title: 'TEST TITLE')
    expect(results).to be_kind_of String
  end
end
