require "spec_helper"

describe Object, ".static_facade" do
  it "creates a class method that instantiates and runs that instance method" do
    klass = Class.new do
      static_facade :fooable?,
        :foo

      def fooable?
        foo
      end
    end

    assert klass.fooable?(true)
    refute klass.fooable?(false)
  end

  it "doesn't require attributes" do
    klass = Class.new do
      static_facade :fooable?

      def fooable?
        true
      end
    end

    assert klass.fooable?
  end

  it "accepts multiple method names" do
    klass = Class.new do
      static_facade [ :fooable?, :barable? ],
        :foo

      def fooable?
        foo
      end

      def barable?
        not foo
      end
    end

    assert klass.fooable?(true)
    assert klass.barable?(false)
  end

  it "passes along any block to the instance method" do
    klass = Class.new do
      static_facade :foo

      def foo
        yield
      end
    end

    assert klass.foo { :bar } == :bar
  end
end
