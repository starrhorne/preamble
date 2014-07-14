Preamble
========

Introduction
------------

The preamble gem lets you add a yaml preamble to your files, much like the Jekyll static site generator


Example
-------

    ---
    key1: value1
    key2: [1, 2, 3]
    ---

    Your body content goes here.


Usage
-----

    # load file with metadata and content
    Preamble.load("./file.xyz") 

    # load multiple files with metadata and content
    Preamble.load_multiple("./file.xyz", "./file.abc") 

    # save metadata and content
    file = Preamble.new({"author" => "Lucky", "year" => 2014}, "My lucky diary.")
    file.save("diary.txt")

    # load, modify metadata, then save
    file = Preamble.load('./file.xyz')
    file.metadata["new_key"] = "factoid"
    file.save('./file.xyz')

Output
------

The Preamble.load function returns a Preamble object. Your data will be in preamble.metadata, and the rest of the content will be in preamble.content.

`preamble.metadata`

    { "key1" => "value1", "key2" => [1, 2, 3] }

`preamble.content`

    "\nYour body content goes here"


Notes
-----

1. The preamble must begin and end with three dashes '---'
2. Whitespace can go above the preamble, but no content
3. This gem is template-agnostic. It doesn't care what your body content is. It just gives it to you as a string.


