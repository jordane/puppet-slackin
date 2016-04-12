require 'spec_helper'

describe 'slackin::instance' do
  let (:title) { 'slackin-test' }
  let (:params) { { :team_id => 'slackin-test', :api_token => 'foobar' } }


  it do
    is_expected.to contain_file('/usr/local/bin/slackin-slackin-test').with({
      'ensure' => 'file',
      'owner' => 'slackin-slackin-test',
      'group' => 'slackin-slackin-test',
      'mode' => '0750',
    }).with_content(/slackin-test foobar$/)
  end

  it { is_expected.to contain_file('/etc/systemd/system/slackin@.service') }
  
  it { is_expected.to contain_user('slackin-slackin-test') }

  it do
    is_expected.to contain_service('slackin@slackin-test').with({
      'enable' => true,
      'ensure' => true
    })
  end
end
