# Worthwhile

[![Join the chat at https://gitter.im/pulibrary/worthwhile](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pulibrary/worthwhile?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/projecthydra-labs/worthwhile.svg?branch=master)](https://travis-ci.org/projecthydra-labs/worthwhile)
[![Coverage Status](https://img.shields.io/coveralls/curationexperts/worthwhile.svg)](https://coveralls.io/r/curationexperts/worthwhile?branch=master)

A very simple extensible IR platform for Hydra

## Installation

Add this line to your application's Gemfile:

    gem 'worthwhile'

And then execute:

    $ bundle

Then:

    $ rails generate worthwhile:install
    $ rake db:migrate

## Testing

    $ rake jetty:clean
    $ rake engine_cart:generate
    $ rake spec

