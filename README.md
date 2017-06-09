# Functional Refactoring in Perl

Functional programming is the oldest but least well known of the three major programming paradigms. While it has a reputation for inscrutability, many of its tenets can be applied to both procedural and object-oriented paradigms to reduce complexity and create cleaner code. In this workshop we'll get a taste of functional programming in Perl and apply the techniques we learn to refactoring and removing common procedural problems related to strong coupling.
 
This repo contains code examples from the corresponding presentation found [here](https://scottw.github.io/presentations/functional-refactoring/).

## Running Examples

To run the examples, `cd` to the repo base, then:

    $ perl 03-modify/customer.pl
    $ perl 08-builders/employee.pl

## Running Tests

To run tests, `cd` to the repo base, then set the `TEST_DIR` environment variable to point to the directory you want to test:

    $ TEST_DIR=09-iterator ct prove -lv t
