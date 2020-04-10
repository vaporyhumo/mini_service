Check the old repo for versions 0.0.x 

[OLD REPO](https://github.com/vaporyhumo/mini_service_archive/tree/v0.0.1)

# MiniService [![Gem Version](https://badge.fury.io/rb/mini_service.svg)](https://badge.fury.io/rb/mini_service)
MiniServices is a rails gem that provides a prototype from which to build
single-functionality minimalistic services.

## TL;DR

Define them like this:

```ruby
class Service < MiniService::Base
  arguments [:required1, :required2], {optional1: 1, optional2: '2'}

  private

  def perform
    return [required1, required2, optional1, optional2]
  end
end
```

You get free readers for every argument defined.

Call the service like this:

```ruby
# You can ommit optional params
> Service.call required1: 1, required2: 2, optional1: 1
=> [1, 2, 1, '2']
```

## Service Pattern

Services are essentially objects whose internal state is never exposed and
whose existance is ephimeral. Or in simpler words it is an object that's
created to perform an action and then destroyed.

You would use a service to perform an action, but would never store the
service's instance.

### My opinion on services

Services are generally not good OOP; but are definitively better than having
classes with more than a hundred or even thousands of lines of code.

Use Services to tidy up your code, learn better OOP and design patterns
so you don't have to.

Do not write services with more than 100 lines of code total, **please**.

## Usage

Use `MiniService::Base` as the parent class for your services and make them
simple!

### Simple Service with no arguments.

You can write a simple service that takes no argument like so:

```ruby
class Service < MiniService::Base
  private

  def perform
    # This is your startpoint, put your code in here
    return 2 + 2
  end
end
```

You can then call it with `.call` like this:

```ruby
> Service.call
=> 4
```

### Service with arguments

Now of course we want to make services take some arguments, so we use the
`arguments` method to define both required and optional arguments.
It takes an array of symbols for the name of required parameters
first, and a hash with the default values for optional parameters then.

```ruby
class Service < MiniService::Base
  arguments [:required], {optional: "I'm a default value'}

  private

  def perform
  end
end
```

Which will let you call your service like this:
```ruby
Service.call required: "I'm mandatory"

# or like this

Service.call required: "I'm mandatory", optional: "I'm not"
```

Attribute readers are automatically defined for every argument, so you
can use them directly inside perform:

```ruby
class Service < MiniService::Base
  arguments [:string]

  private

  def perform
    return string
  end
end

> Service.call string: 'Hola mundo'
=> 'Hola mundo'
```

### Making `.new` public again

If you try to instantiate a `MiniService` you will get an error.

```ruby
class Service < MiniService::Base
  private

  def perform
  end
end

> Service.new
=> NoMethodError
```

If you really want to create instantiable services -which kind of 
defeats the whole purpose of this gem alltogether- you can use 
`public_class_method :new` to reenable it.

```ruby
class Service < MiniService::Base
  public_class_method :new

  private

  def perform
  end
end

> Service.new
=> #<Service:0x0000000000000001>
```

### Overwritting `#initialize`

This SHOULD work out, tho I have not tested it nor tried it.

DO NOT add arguments to initialize!!

```ruby
  class Service < MiniService::Base
    def initialize
      super
      # extra initialization here
    end
  end
```

You are supposed to set up the service's initial state
through its arguments, and define any other thing using private methods,
but anyhow, that's up to you.

## Contributing / License

Everyone is free to use this code for whatever they want.
No one is allowed to apply any license over this code or anything
created using this code as its base.
Any variation of this gem should be free and open source.

Use `bin/setup` to setup your development environment.

You are free to open pull requests, I will check them out, but I'm not
intending to do much more with this but fixing any potential bug.
