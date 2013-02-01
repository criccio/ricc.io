ricc.io
=======

This is a simple link shortening service built in rails that i am running on http://ricc.io for my own use.
It supports creating your own short code, or will autogenerate one. It also will keep a hitcount for each code. 
It protects the link creation with a configurable basic auth username and password.

To use, create a config/local_env.yml file with these 3 values set:

RICC_IO_SECRET_TOKEN - the cookie secret token

RICC_IO_ADMIN_USER - the admin user name

RICC_IO_ADMIN_PASSWORD - the admin password

For example, this shortcode will redirect to my github profile: http://ricc.io/github 

and this one redirects to Expedia: http://ricc.io/rYOLf

