require 'spec_helper'
describe 'slackin' do

  context 'with defaults for all parameters' do
    it { should contain_class('slackin') }
  end
end
