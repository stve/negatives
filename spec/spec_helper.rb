require 'simplecov'
SimpleCov.start

require File.expand_path('../../lib/negatives', __FILE__)

require 'rspec'
require 'webmock'
include WebMock::API
