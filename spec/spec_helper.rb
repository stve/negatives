require 'simplecov'
SimpleCov.start

require File.expand_path('../../lib/negatives', __FILE__)

require 'rspec'
require 'webmock'
include WebMock::API

def stub_redirect(url, redirect_url)
  stub_request(:get, url).to_return(:status => 301, :headers => { 'Location' => redirect_url })
end

def stub_success(url, body = '')
  stub_request(:get, url).to_return(:status => 200, :body => body)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end