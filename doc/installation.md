# Installing Tracks

The following instructions will guide you through the installation of Tracks from source.

This description is intended for people installing Tracks from scratch. If you would like to upgrade an existing installation, please see the [upgrade documentation](upgrading.md).

Sparta Tracks is based on the open source application, Tracks. Users have contributed installation howtos for specific environments. They are [on the Tracks wiki](https://github.com/TracksApp/tracks/wiki/Installation-index). Note that there may be some additional steps required for the Sparta version of this source code.

## Prerequisites

Tracks has a few software requirements that must be satisfied before installation:

1. **Ruby**. Tracks requires Ruby 1.9.3 or greater.
2. **Bundler**. Tracks requires a recent version of [Bundler](http://bundler.io) to handle the installation of dependencies. Bundler is typically installed by running `gem install bundler`.
3. **Database**. Tracks is tested on [MySQL](http://www.mysql.com/), but [SQLite](http://www.sqlite.org/) and [PostgreSQL](http://www.postgresql.org/) can also be used. Of the three, SQLite requires the least configuration. Whatever your choice, the appropriate database software must be installed. Because MySQL is set up by defauly, you should use this when testing the software.

## Get Tracks set up.

Clone the repositary onto your local machine.

## Set up the database

*This section only applies if you will be using Tracks with a MySQL database.*

You need to create a database and database-user to use with Tracks. For this, you can use MySQL Administrator tool or go into a terminal and issue the following commands:

    mysql -uroot -p
    mysql> CREATE DATABASE tracks;
    mysql> GRANT ALL PRIVILEGES ON tracks.* TO tracks@localhost \
    IDENTIFIED BY 'password-goes-here' WITH GRANT OPTION;

## Install dependencies

Tracks is built upon a number of Ruby libraries (known as ‘gems’). The Bundler tool makes it easy to install all the gems that Tracks needs, and ensures that they are all the correct versions.

1. Edit the file `Gemfile` in the Tracks root directory. You may comment out any database drivers you will not be using. You may also comment out `therubyracer` if you are installing Tracks on Windows or Mac OS X, or if you have another JavaScript runtime such as Node.js installed.
2. Run the command `bundle install` in the directory that you unzipped your Tracks download to.
3. Wait for Bundler to finish installing the necessary gems that Tracks needs. This can take some time depending on the speed of your internet connection and the speed of the system you’re installing Tracks on.

## Configure variables

1. In the `config` folder, copy the files `database.yml.tmpl` and `site.yml.tmpl` to `database.yml` and `site.yml`, respectively.
2. Open the file `config/database.yml` and edit the`development:` and `production:` sections with the details of your database. If you are using MySQL the `adapter:` line should read `adapter: mysql2`, `host: localhost` (in the majority of cases), and your username and password should match those you assigned when you created the database. If you are using SQLite3, you should have only two lines under the production section: `adapter: sqlite3` and `database: db/tracks.db`.
3. Open the file `config/site.yml`, and read through the settings to make sure that they suit your setup. In most cases, all you need to change are the `salt: "change-me"` line (change the string “change-me” to some other string of your choice), the administrator email address (`admin_email`), and the time zone setting. For the time zone setting you can use the command `bundle exec rake time:zones:local` to see all available timezones on your machine
4. If you are using Windows, you may need to check the ‘shebang’ lines (`#!/usr/bin/env ruby`) of the `/public/dispatch.*` files and all the files in the `/script` directory. They are set to `#!/usr/bin/env ruby` by default. This should work for all Unix based setups (Linux or Mac OS X), but Windows users will probably have to change it to something like `#c:/ruby/bin/ruby` to point to the Ruby binary on your system.
5. If you intend to deploy Tracks with the built in webserver called WEBrick, you’ll need to change `config.serve_static_assets` to `true` in `config/environments/production.rb` in order for the images, stylesheets, and javascript files to be served correctly.

## Populate your database with the Tracks schema

Open a terminal and change into the root of your Tracks directory. Enter the following command:

    bundle exec rake db:migrate RAILS_ENV=production

This will set up your database with the required structure to hold Tracks’ data.

## Precompile assets

Static assets (images, stylesheets, and javascript) need to be compiled in order for them to work correctly with the new asset pipeline feature in Rails. Precompiling your assets is as simple as running the following command while inside the Tracks root directory:

    bundle exec rake assets:precompile RAILS_ENV=development

## Start the server

While still in the Terminal inside the Tracks root directory, issue the following command:

    bundle exec rails server -e development

If all goes well, you should see some text informing you that the WEBrick server is running: `=> Rails application starting in development on http://0.0.0.0:3000`. If you are already running other services on port 3000, you need to select a different port when running the server, using the `-p` option.

## Visit Tracks in a browser

Visit `http://0.0.0.0:3000/signup` in a browser (or whatever URL and port was reported when you started the server in the step above) and chose a user name and password for admin user. Once logged in as admin, you can add other (ordinary level) users. If you need to access Tracks from a mobile/cellular phone browser, visit `http://yourdomain.com/mobile/`. This mobile version is a special, lightweight version of Tracks, designed to use on a mobile browser.

## Customise Tracks

Once logged in, add some Contexts and Projects, and then go ahead and add your actions. You might also want to visit the Preferences page to edit various settings to your liking. Have fun!
