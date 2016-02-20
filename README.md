# Plans

Command line application for creating markdown documents from templates and publishing them in MS Word.

> Plans are nothing; planning is everything. --Dwight D. Eisenhower

Plans was originally created to manage functional specifications and scope documents for our projects. I prefer to write in [markdown](https://daringfireball.net/projects/markdown/), but many of our clients would prefer to review documents in MS Word. Plans (well [Pandoc](http://pandoc.org) really!) bridges that gap allowing us to create these documents in markdown and publish them in MS Word. It also allows us to manage our requirements documents more like code. We keep them all in git (either on [Github](https://github.com) or [Bitbucket](https://bitbucket.org)) and manage changes to them via pull requests. As a side benefit, the built in markdown browsing capabilities available on both BitBucket and GitHub are really handy. That's why, as you will see, most of the markdown files in the documents are named README.md. This way they are available in GitHub or BitBucket as the Readme file for the directory.

Plans ships with templates (DOC_TYPEs) for managing the requirements for a typical project.

* Vision and Scope document
* Functional Specification
* User Classes and Characteristics
* Glossary
* Plain Document 

These are just examples and its easy to make your own templates. We also use plans to manage our proposals, agreements, and statements of work.

## Prerequisites

Plans has only been tested on MacOS. If you *really* want to use it in Windows, let me know.

Plans depends on [Pandoc](http://pandoc.org) and [ImageMagik](http://imagemagick.org) to do a lot of the heavy lifting. These will need to be installed first.

There are many ways to do this, but probably the easiest is to use [Homebrew](http://brew.sh).

Once homebrew is installed, you can easily install Pandoc.

    $ brew install pandoc
    
ImageMagick works pretty much the same way.

    $ brew install imagemagick

You also need Microsoft Word. :)

## Installation

Install it:

    $ gem install plans

## Usage

To get started, try:

    $ plans help
    
This will show you what plans can do. It will also let you know if you have plans installed correctly.

Plans allows you to define a set of document templates, or DOC_TYPEs. These are stored in your home directory in a `.plans` folder. To create this folder with a default set of documents do the following.

    $ plans init

Then take a look at the `.plans` directory in your home directory. If you want to customize the templates, check out the README.md in the root of the `.plans` directory.

To see what types of documents you can create do the following.

    $ plans list

To create a new functional specification, do the following.

    $ plans new functional

You can then edit the README.md that is created by plans. To turn that markdown document into MS Word, just navigate into the directory where the file is located and type:

    $ plans publish

### Images

Making an image heavy document in markdown can be kind of a pain and functional specifications for a user interface tend to have a lot of mockups, screenshots, and diagrams. With plans, you can just export those images to the `img` folder and include them like you would for markdown normally. Something like this:

    ![A Screenshot](./img/Fullscreen_10_12_15__11_34_AM.png)

This is all well and good, but sometimes those images are huge and they don't get automatically resized in Word. Manually resizing all of the images in a Word document rapidly becomes very tedious.

So, plans uses Imagemagick to make reasonable sized versions of any images in your documents `img` folder. To learn more, try:

    $ plans help thumbs

Plans will make 200px, 400px, and 600px wide versions of these images. You can then include them in your document like this:

    ![A Screenshot](./img/400px/Fullscreen_10_12_15__11_34_AM.png)

No more manually resizing images in Word!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/code-lever/plans.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

