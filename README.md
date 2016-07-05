# Craft Boilerplate

This repo is a boilerplate for [Craft CMS](http://buildwithcraft.com/). It uses Node, Grunt, Bower, and Bootstrap to generate template and asset files.

- - -

## Getting Started

To get this project up and running, follow these steps:

### Environment Setup

1. Make sure you've got Node installed on your system.
2. Open a terminal and navigate to the project directory.
3. Type `npm install` to install the project's back-end (Node/Grunt) dependencies. This might take a couple of minutes to finish.
4. Type `bower install` to install the project's front-end (Bower) dependencies.
5. Type `grunt` to build the template/asset files for the site and watch for changes to the files in the `dev/` folder. If you're not interested in watching the project, type `grunt build` instead.

### Craft Setup

6. Type `chmod -R 774 craft/{app,config,storage}` to make sure Craft can edit certain files.
7. Change the database settings in `craft/config/db.php` to point to an empty MySQL database that you control.
8. Make sure that the project is accessible on your local or remote server. Note: Craft will allow you to try out the two commercial tiers of its software if the domain name ends in `craft.dev`. With that in mind, it may be useful to develop locally using a domain pattern like `http://projectname.craft.dev/`.
9. Open a browser and navigate to Craft's admin URL (e.g. `http://projectname.craft.dev/admin/`). This walkthrough will help you install Craft on your server.

- - -

## Working with Grunt

The folder structure of this project looks like this:

    ./
      bower/
        [bower packages]
      craft/
        app/
        config/
        plugins/
        storage/
        templates/
      dev/
        assets/
          css/
          img/
          js/
        templates/
      public/
        assets/
        uploads/

### Craft Templates

We develop our Craft templates in the `dev/templates/` folder. Grunt minimizes these templates and stores the optimized files in the `craft/templates/` folder.

### Assets

We develop the project's front-end assets in the `dev/assets/` folder. Our CSS is written in Sass and our JS is written in Coffeescript. Grunt compiles and optimizes these files, and then saves them to their appropriate CSS/JS locations in the `public/assets/` folder.

### Bootstrap

We use Bootstrap on this project, but we've decided to take a 'piecemeal' approach to it. This workflow is kind of messy right now, but it's preferable to including _all_ of Bootstrap regardless of what parts you're using.

To control which Bootstrap styles are included in the project, comment or uncomment lines in the file located at `dev/assets/css/bootstrap.sass`. To control which Bootstrap scripts are included, open `Gruntfile.coffee` and comment/uncomment the script lines within the `concat:bootstrap_js` Grunt task. After modifying the script lines, it's a good idea to restart the Grunt watcher to make sure that it compiles those files correctly.
