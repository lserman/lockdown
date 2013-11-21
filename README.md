Lockdown
========

Authorization library for Rails - somewhere between CanCan and Pundit.

* This is a README first repo

Installation
========

Usage
========

Like many libraries (CanCan, InheritedResources, etc...), Lockdown will preload your records in an instance variable so 
that they can be authorized automatically in a before filter. To do this, Lockdown uses the `preload` method. Using 
Lockdown's method is completely optional, you can instead use the common Rails practice of making a custom `set_whatever` 
filter if you wish.

Lockdown uses 'Authorizers' (similar to Pundit policies) to authorize your resource. Also like Pundit, each Authorizer 
responds to each controller method and returns true or false depending on your authorization logic.

Preloading your resource
========

A naked `preload` will load the resource based on the controller name:

```
class UsersController < ApplicationController
  preload # @user = User.find(params[:id])
end
```

If your resource is named differently, you can also pass in the class name as a symbol:

```
class UsersController < ApplicationController
  preload :alien # @alien = Alien.find(params[:id])
end
```

`preload` can also accept a block and use the return value as the resource. Passing a symbol into `preload` along with 
the block will change the instance variable naming.

```
class UsersController < ApplicationController
  preload :alien do
    Alien.find_by(name: params[:name])
  end
```

You can also override the `_resource` method in your controller instead.

```
class UsersController < ApplicationController
  preload # @user = resource
  
  private
  
    def _resource
      Alien.find_by(name: params[:name])
    end
    
end
```

Alternatively, you can use whatever finder you want as long as something is loaded before `lockdown`.

Locking it down
========

`lockdown` authorizes a resource by using an `Authorizer` class (by default), although you can change the 
implementation to whatever you want. An Authorizer's only requirement is that it responds to `call(resource, action)` 
and returns true or false depending on your authorization logic.

The default authorizers inherit from `Lockdown::Authorizer`, which finds the correct authorizer based on the resource 
name and then calls `#{action}?` on it. The current record is accessible via `record`, and the current user via `user`. 
Here is a simple example of an authorizer:

```
class PostAuthorizer < Lockdown::Authorizer
  def update?
    record.owner == user
  end
end
```

`lockdown`
========

A naked `lockdown` will infer your model and authorizer based on the controller name.

```
class PostsController < ApplicationController
  preload and lockdown # PostAuthorizer.new.call(@post, params[:action])
end
```

Because the Authorizers only need to respond to `call`, you can also send a block or lambda:

```
class PostsController < ApplicationController
  preload
  lockdown do |record, action|
    record.public? && current_user.present?
  end
```

If you have a custom permission system or something like that, you can send in any class that responds to 
`call(resource, action)`:

```
class PostsController < ApplicationController
  preload
  lockdown :post, YourImplementation.new
end
```

Todo...


