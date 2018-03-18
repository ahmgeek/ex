# frozen_string_literal: true

require 'redic'
require 'dotenv/load'

DB = Redic.new(ENV['REDIS_URL'])
