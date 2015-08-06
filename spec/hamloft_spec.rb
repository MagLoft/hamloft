require 'hamloft'
RSpec.describe Hamloft do

  it "renders a custom hamloft template" do
    
    require_relative "fixtures/template/tumblr.rb"
    Hamloft.register_template(:tumblr, TumblrTemplate)
    
    haml = File.read("spec/fixtures/test.haml")
    results = Hamloft.render(haml, {
      html: "<p>foo</p><p>bar</p>"
    })
    expect(results).to be_kind_of String
  end
  
end
