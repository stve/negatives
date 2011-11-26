require 'simplecov'
SimpleCov.start

require File.expand_path('../../lib/negatives', __FILE__)

require 'rspec'
require 'webmock'
require 'rash'
include WebMock::API

def stub_redirect(url, redirect_url)
  stub_request(:head, url).to_return(:status => 301, :headers => { 'Location' => redirect_url })
  stub_request(:get, url).to_return(:status => 301, :headers => { 'Location' => redirect_url })
end

def stub_success(url, body = '')
  stub_request(:head, url).to_return(:status => 200, :headers => {})
  stub_request(:get, url).to_return(:status => 200, :body => body, :headers => {})
end

def stub_failure(url)
  stub_request(:head, url).to_return(:status => 500, :body => '', :headers => {})
  stub_request(:get, url).to_return(:status => 500, :body => '', :headers => {})
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end