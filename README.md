# Exchangefy

A lib and endpoint to quickly exchange between Europeans currencies and EUR.

## Setup

run `rvm use --create --ruby-version ruby-2.4.2@ER`
to setup ruby versions.

Clone the repo `git clone git@gitlab.com:ahmgeek/exchangefy.git`

run `bundler` in the root of the project dir.


## Runing

### To start the web server:

`thin start`

From browser:

  * `localhost:3000`
  * `localhost:3000/convert?currency=SEK&value=32423`

The `lib/scrapper.rb` is executable, and can be added to cronjob,
better to use it in background job.

## Tests
run `rspec` from the root dir of the project.

## Notes

The 90 day European Central Bank only provides ER against Euro only,
hence, the lib is limited to change between currencies and Euro.

