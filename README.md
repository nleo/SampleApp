    ansible-playbook -i hosts site.yml

```yaml
# site.yml
---
- hosts: railsapp
  vars:
    ruby_version: 2.4
    postgresql_version: 9.6
    deploy_user: rails
    app_name: SampleApp
    domain: site.example
    repo_url: git@github.com:nleo/SampleApp.git
    app_path: /home/{{deploy_user}}/{{app_name}}
    database: "{{app_name}}"
    dbuser: "{{app_name}}"
    dbpass: password
  remote_user: root
  roles:
    - common
    - bash
    - ruby
    - postgresql
    - { role: passenger, tags: [ 'passenger' ] }
```

```inifile
# hosts 
[railsapp]
site.example
```

```ruby
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
end
```

```ruby
# Capfile
$ansible_vars = YAML.load_file('site.yml').first['vars'].symbolize_keys

require "capistrano/setup"
require "capistrano/deploy"
require 'capistrano/rails'
require 'capistrano/passenger'
```

```ruby
# config/deploy.rb
set :application, $ansible_vars[:app_name]
set :repo_url, $ansible_vars[:repo_url]
set :deploy_to, "/home/#{$ansible_vars[:deploy_user]}/#{$ansible_vars[:app_name]}"
```

```ruby
# config/deploy/production.rb
server $ansible_vars[:domain], user: $ansible_vars[:deploy_user]
```
