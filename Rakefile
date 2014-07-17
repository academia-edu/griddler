#!/usr/bin/env rake
begin
  require 'bundler/setup'
  require 'bundler/gem_tasks'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: :spec

desc "Tag #{Bundler::GemHelper.new.send(:version_tag)}, build and push to gemfury"
task :release_internal do |t|
  require 'gemfury'

  class ReleaseInternalGem < Bundler::GemHelper
    def release_gem
      guard_clean
      built_gem_path = build_gem
      tag_version { git_push } unless already_tagged?
      `fury push #{built_gem_path}`
      Bundler.ui.confirm "Pushed #{name} #{version} to gemfury"
    end
  end

  ReleaseInternalGem.new.release_gem
end

module Bundler
  class GemHelper
    def release_gem
      raise 'STOP. This is an internal gem. Use `rake release_internal` instead'
    end
  end
end

