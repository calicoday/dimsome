# Porkbelly -- an alternate-history prequel to Bacon/MacBacon
#
# Copyright (C) 2020 Calicoday calicoday@gmail.com
#
# Drawn from:
#
#   Bacon -- small RSpec clone.
#
#   "Truth will sooner come out from error than from confusion." ---Francis Bacon
#
#   Copyright (C) 2007, 2008, 2012 Christian Neukirchen <purl.org/net/chneukirchen>
#
# and from:
#
#   Copyright (C) 2011 Eloy Durán eloy.de.enige@gmail.com
#
# Porkbelly is freely distributable under the terms of an MIT-style license.
# See COPYING or http://www.opensource.org/licenses/mit-license.php.


module Porkbelly
  VERSION = "0.2"
  
  module SpecDoxReport
    def report_specification(name)
      puts spaces + name
      yield
      puts if Tracker.one.depth == 1
    end

    def report_requirement(description)
      s = "#{spaces}  - #{description}"
      error = yield
      puts error.empty? ? "#{s}" : "#{s} [#{error}]"
    end

    def report_summary
      puts ErrorLog 
      puts "%d specifications (%d requirements), %d failures, %d errors" %
        Tracker.one.values
    end

    def spaces
      "  " * (Tracker.one.depth - 1)
    end
  end

	class Tracker
		attr_reader :stack, :specs, :reqs, :failures, :errors, :shoulds
		
		def self.one
			@@there_can_be_only_one ||= Tracker.new
		end
		def initialize() 
			@specs = @reqs = @failures = @errors = @shoulds = 0
			@stack = []
		end
		def depth() stack.length end
		def down(v=nil) 
			unless v
				v = Context.new("ContextStop"){}
				@specs += 1
				@should = 0
			end
			stack.push(v)
# 			v ? stack.push(v) : stack.push(@context_stop)
			v 
		end
		def up() 
			v = stack.pop 
			@reqs += @shoulds if v.name == "ContextStop"
			@shoulds = 0
		end
		def top?() depth == 0 end
		def empty_spec?() @shoulds == 0 end
		def plus_should() @shoulds += 1 end
		def plus_req() @reqs += 1 end
		def plus_error() @errors += 1 end
		def plus_failure() @failures += 1 end
		def values() [specs, reqs, failures, errors] end
		
    def run_before(&block)
    	stack.each{|e| e.beforelist.each{|pre| yield(pre)}}
    end
    def run_after(&block)
    	stack.reverse.each{|e| e.afterlist.each{|post| yield(post)}}
    end
	end
  
  
  ErrorLog = "".dup
  # no shared!!! FIXME!!!

  class Error < RuntimeError
    attr_accessor :count_as

    def initialize(count_as, message)
      @count_as = count_as
      super message
    end
  end

  extend Porkbelly::SpecDoxReport 

	# prob not nec, since specs are run as they're read in
	def self.run() 
		report_summary
		exit(0)
	end

  class Context
    attr_reader :name, :block

    def initialize(name, &block)
      @name = name
      @before, @after = [], []
      @block = block
    end

    def raise?(*args, &block) block.raise?(*args)end
    def throw?(*args, &block) block.throw?(*args) end
    def change?(*args, &block) block.change?(*args) end

		### do better!!! FIXME!!!
		def beforelist() @before end
		def afterlist() @after end
    def before(&block) @before << block end
    def after(&block)  @after << block end

    def run_context
### DragonRuby-GTK no regex
#       return  unless name =~ RestrictContext

  		Tracker.one.down(self)
      Porkbelly.report_specification(name) { instance_eval(&block) }
    	Tracker.one.up
      self
    end
    
    def describe(*args, &block) 
    	Kernel.describe(args.join(' '), &block) 
    end
    alias_method :context, :describe

    def it(description, &block)
### DragonRuby-GTK no regex
#       return  unless description =~ RestrictName

			# do we want this check??? FIXME!!!
#       block ||= proc { should.flunk "not implemented" }
			run_spec(description, block)
    end
        
    def run_reqs(description, spec)
			rescued = false
			begin
				Tracker.one.run_before{|pre| instance_eval(&pre)}
				instance_eval(&spec)
			rescue Object => e
				rescued = true
				raise e
			ensure
				if Tracker.one.empty_spec? && !rescued
					raise Error.new(:missing, "empty specification: #{@name} #{description}")
				end
				begin
					Tracker.one.run_after{|post| instance_eval(&post)}
				rescue Object => e
					raise e unless rescued
				end
			end
    end
    
    def run_spec(description, spec)
      Porkbelly.report_requirement description do
        begin
					Tracker.one.down()
          run_reqs(description, spec)
        rescue Object => e
          ErrorLog << "#{e.class}: #{e.message}\n"
### DragonRuby-GTK no regex
					# can't filter, so skip the backtrace for now. FIXME!!!
#           e.backtrace.find_all { |line| line !~ /bin\/bacon|\/bacon\.rb:\d+/ }.
#             each_with_index { |line, i|
#             ErrorLog << "\t#{line}#{i==0 ? ": #@name - #{description}" : ""}\n"
#           }
#           ErrorLog << "\n"

          if e.kind_of? Error
						# just test for :failed for now
						Tracker.one.plus_failure if e.count_as == :failed
						"#{e.count_as.to_s.upcase} - #{e}"
          else
						Tracker.one.plus_error
						 "ERROR: #{e.class} - #{e}"
          end
        else
          ""
        ensure
					Tracker.one.up
        end
      end
    end
    
### DragonRuby-GTK warns unless these defd
		def serialize()
			instance_variables.each_with_object({}) do |ivar, collector|
					collector[ivar] = instance_variable_get(ivar)
			end
		end
		def inspect() serialize.to_s end
		def to_s() serialize.to_s end

	end  

	class Should
		# Kills ==, ===, =~, eql?, equal?, frozen?, instance_of?, is_a?,
		# kind_of?, nil?, respond_to?, tainted?
### DragonRuby-GTK no regex
# 	  instance_methods.each { |name| undef_method name  if name =~ /\?|^\W+$/ }

		# remove these specifically -- nec all of these???
		instance_methods.each { |name| undef_method name if [
			:==,
			:respond_to_missing?,
			:respond_to?,
			:is_a?,
			:kind_of?,
			:instance_of?,
			:instance_variable_defined?,
			:<=>,
			:eql?,
			:!~,
			:=~,
			:===,
			:!=,
			:!,
			:nil?,
			:equal?,
			:false?,
			:true?,
			:untrusted?,
			:frozen?,
			:tainted?,
			### and RubyMotion-specific forms
			:"==:",
			:"respond_to_missing?:",
			:"respond_to?:",
			:"is_a?:",
			:"kind_of?:",
			:"instance_of?:",
			:"instance_variable_defined?:",
			:"<=>:",
			:"eql?:",
			:"!~:",
			:"=~:",
			:"===:",
			:"!=:",
			:"equal?:",
			### ham 
# 			:raise,
# 			:"raise:",
			].include?(name) }

### DragonRuby-GTK Objects already know :raise (RubyMotion's don't seem to)
		# and we want to go through method_missing
		alias_method :orig_raise, :raise
		undef_method :raise

		def initialize(object)
			@object = object
			@negated = false
		end
	
# 	  def not(*args, &block)
# 	    @negated = !@negated
# 	  	return self if args.empty?
# 			be(*args, &block)
# 	  end
# 	
# 	  def be(*args, &block)
# 	  	return self if args.empty?
# 			block = args.shift unless block_given?
# 			satisfy(*args, &block)
# 	  end
		def not(*args, &block)
			@negated = !@negated

			if args.empty?
				self
			else
				be(*args, &block)
			end
		end

		def be(*args, &block)
			if args.empty?
				self
			else
				block = args.shift  unless block_given?
				satisfy(*args, &block)
			end
		end

		alias a  be
		alias an be

		def satisfy(description="", &block)
			r = yield(@object)
			unless Porkbelly::Tracker.one.top?
				Porkbelly::Tracker.one.plus_should
				orig_raise Porkbelly::Error.new(:failed, description) unless @negated ^ r
				r
			else
				@negated ? !r : !!r
			end
		end

		def method_missing(name, *args, &block)
### DragonRuby-GTK no regex
			#name = "#{name}?"  if name.to_s =~ /\w[^?]\z/

			# if @object has a -? form of the method, go with that
			name = "#{name}?" if @object.respond_to?("#{name}?")

			desc = @negated ? "not ".dup : "".dup
			desc << @object.inspect << "." << name.to_s
			desc << "(" << args.map{|x|x.inspect}.join(", ") << ") failed"

			satisfy(desc) { |x| x.__send__(name, *args, &block) }
		end

		def equal(value)         self == value      end
### DragonRuby-GTK no regex
	#   def match(value)         self =~ value      end
		def identical_to(value)  self.equal? value  end
		alias same_as identical_to

		def flunk(reason="Flunked")
			orig_raise Porkbelly::Error.new(:failed, reason)
		end
	end
end

class Object
  def true?() false end
  def false?() false end
end

class TrueClass
  def true?() true end
end

class FalseClass
  def false?() true end
end

class Numeric
  def close?(to, delta)
    (to.to_f - self).abs <= delta.to_f rescue false
  end
end


class Proc
  def raise?(*exceptions)
    call
  rescue *(exceptions.empty? ? RuntimeError : exceptions) => e
    e
  else
    false
  end

  def throw?(sym)
    catch(sym) {
      call
      return false
    }
    return true
  end

  def change?
    pre_result = yield
    call
    post_result = yield
    pre_result != post_result
  end
end

class Object
  def should(*args, &block) Porkbelly::Should.new(self).be(*args, &block) end
end

module Kernel
  def describe(*args, &block) 
  	Porkbelly::Context.new(args.join(' '), &block).run_context 
  end
end

