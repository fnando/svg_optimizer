# frozen_string_literal: true

require "rake/testtask"
require "bundler/gem_tasks"
require "rubocop/rake_task"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
end

RuboCop::RakeTask.new

task default: %i[test rubocop]
