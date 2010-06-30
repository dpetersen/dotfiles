#!/usr/bin/ruby
# (c) 2008 Bruce Williams, http://codefluency.com
# MIT License

require 'rubygems'
require 'optparse'

class ViewGem
  
  attr_reader :name
  def initialize
    parser.parse!(ARGV)
    @name = ARGV.shift
    validate!
  end
  
  def requirement
    @requirement || Gem::Requirement.new('>= 0.0.0')
  end
  
  def run
    unless path
      abort "Could not find #{name} #{requirement}"
    else
      open
    end
  end
  
  def open
    # We don't use system or exec with arguments because they
    # don't like it if editor includes arguments (ie, 'mate -w')
    system "#{editor} '#{path}'"
  end
  
  #######
  private
  #######
  
  def validate!
    unless name
      abort "ERROR: Must provide gem name.\n---\n#{parser}"
    end
  end
  
  def path
    @path ||= begin
      Gem.source_index.search(/^#{name}$/, requirement).last.full_gem_path rescue nil
    end
  end
  
  def parser
    OptionParser.new do |opts|
      opts.banner = "viewgem NAME [OPTIONS]\nOPTIONS:"
      opts.on('-v VERSION', '--version', 'Specify gem version') do |raw_req|
        @requirement = Gem::Requirement.new(raw_req)
      end
      opts.on_tail('-h', '--help', 'Show this message') do
        abort opts.to_s
      end
    end
  end
  
  def editor
    env_editor = ENV['VIEWGEM_EDITOR'] || ENV['EDITOR']
    return env_editor if env_editor
    case RUBY_PLATFORM
    when /darwin/
      'mate'
    else
      # I actually prefer Emacs, but vi[m] is more ubiquitous,
      # so a better default
      'vi' 
    end
  end
  
end

ViewGem.new.run


