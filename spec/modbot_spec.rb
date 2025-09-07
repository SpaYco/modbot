# frozen_string_literal: true

require 'spec_helper'
require 'mod_bot'

describe ModBot do
  it 'has a version number' do
    expect(ModBot::VERSION).not_to be_nil
  end
end
