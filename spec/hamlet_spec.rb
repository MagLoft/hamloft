require 'hamlet'
RSpec.describe Hamlet do

  it "renders a custom hamlet template" do
    
    require_relative "fixtures/template/tumblr.rb"
    Hamlet.register_template(:tumblr, TumblrTemplate)
    
    haml = File.read("spec/fixtures/test.haml")
    results = Hamlet.render(haml, {
      html: "<p>foo</p><p>bar</p>"
    })
    expect(results).to be_kind_of String
  end
  
end
