# Tracks: The Sparta Task Management Application

## Installation

Full instructions for both new installations and upgrades from older installations of Tracks can be found within the /doc directory.

## Testing

The application is a Ruby on Rails app and uses Rails MiniTest for unit, functional and integration tests. The Rails generators are also covered by MiniTest tests.

Automated UAT is covered by cucumber features.

### Available Testing Rake Tasks

Note that you can see all the available rake tasks with `rake -T`.

```
rake test:units        # Runs all unit tests
rake test:functionals  # Runs functional tests
rake test:integration  # Runs all integration tests
rake test:generators   # 
rake features          # Runs cucumber automated acceptance tests
rake test              # Runs test:units, test:functionals, test:generators, test:integration together
rake test:all          # Run tests quickly by merging all types and not resetting db
rake test:all:db                        # Run tests quickly, but also reset db

```
