=begin
Great example of using NullObject pattern taken from thoughtbot:
https://github.com/thoughtbot/factory_girl/blob/master/lib/factory_girl/null_object.rb
=end

class NullObject < ::BasicObject
  def initialize(methods_to_respond_to)
    @methods_to_respond_to = methods_to_respond_to.map(&:to_s)
  end

  def method_missing(name, *args, &block)
    if respond_to?(name)
      nil
    else
      super
    end
  end

  def respond_to?(method, include_private=false)
    @methods_to_respond_to.include? method.to_s
  end

  def respond_to_missing?(*args)
    false
  end
end