# Tap If

## Install / Use

In your `Gemfile` add: `gem 'tap_if'`  
Then run `bundle install`.  
Add `require 'tap_if'` before you use it.  

##Examples

Delegates to Object#tap if the `caller` is truthy or given the `method name + args` evaluate to
a truthy value. Useful for clarity - always return the caller but only
execute the block when the condition passes.

```ruby
# Update the user's account token if the user is an admin of the account.

User.find(user_id).tap_if(:admin?, account) do |user|
  user.update_token(account)
end

# Only update twitter/facebook if the post actually publishes.

def publish
  (post.pending? && post.update_attributes(:published => true)).tap_if do
    the_update = "New blog post: #{post.title[0..100]}... #{post.link}"

    Twitter.update(the_update)
    Facebook.update(the_update)
  end
end
```

##The Motivation

I found myself assigning a variable and doing something to it if a condition passed.
This pattern leaves dangling `ifs` on the end of lines and is simply less clear than
code that will execute if the line is reached.


```ruby
# I found myself doing (a contrived version):

user = User.where(:email => email).first
user.update_attributes(:status => "active") if user.present? && user.admin?

#But now I can do:

User.where(:email => email).first.tap_if(:admin?) do |user|
  user.update_attributes(:status => "active")
end

# In essence we always update the user assuming we get there.
```

## License

License: MIT-LICENSE (LICENSE.md)

