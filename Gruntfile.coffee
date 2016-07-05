'use strict'

module.exports = (grunt) ->

  # -------------------------------------------------------------------------- #
  # Project configuration
  # -------------------------------------------------------------------------- #
  grunt.initConfig

    # Read in the package.json file data
    # ------------------------------------------------------------------------ #
    pkg: grunt.file.readJSON('package.json')
    db: grunt.file.readJSON('db.json')
    # Path settings
    # ------------------------------------------------------------------------ #
    path:

      # Base locations
      dev:    'dev'
      craft:  'craft'
      public: 'wwwroot'

      # ToDo - make this an automated vendor include approach
      # Bower components
      jquery: 'bower/jquery/dist'

    # Clean - Empties build directories
    # ------------------------------------------------------------------------ #
    clean:
      templates: [
        '<%= path.craft %>/templates/*',
        '!<%= path.craft %>/templates/.gitignore'
      ]
      assets: [
        '<%= path.public %>/assets/*',
        '!<%= path.public %>/assets/.gitignore'
      ]

    # Coffee - JS Proprocessor
    # ------------------------------------------------------------------------ #
    coffee:
      options:
        sourceMap: true
      build:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/js'
          src: '**/*.coffee'
          dest: '<%= path.public %>/assets/js'
          ext: '.js'
        ]

    # Concat some files
    # ------------------------------------------------------------------------ #
    concat:
      options:
        sourceMap: false
        stripBanners: true
      dist:
        src: [
          "<%= path.public %>/assets/js/lib/jquery.js"
          "<%= path.public %>/assets/js/libs/foundation.js"
          "<%= path.public %>/assets/js/libs/underscore.js"
          "<%= path.public %>/assets/js/libs/bowser.js"
          "<%= path.public %>/assets/js/libs/sine-waves.js"
          "<%= path.public %>/assets/js/libs/mapbox.js"
          "<%= path.public %>/assets/js/libs/tinycolor.js"
          "<%= path.public %>/assets/js/libs/video.js"
          "<%= path.public %>/assets/js/libs/youtube.js"
          "<%= path.public %>/assets/js/libs/slick.js"
          "<%= path.public %>/assets/js/libs/backstretch.js"
          "<%= path.public %>/assets/js/_global.js"
          "<%= path.public %>/assets/js/_waves.js"
          "<%= path.public %>/assets/js/_maps.js"
          "<%= path.public %>/assets/js/application.js"
        ]
        dest: '<%= path.public %>/assets/js/scripts.js'
      jquery:
        files: '<%= path.public %>/assets/js/lib/jquery.js': '<%= path.jquery %>/jquery.min.js'

    # Copy files from A to B
    # ------------------------------------------------------------------------ #
    copy:
      gif:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.gif'
          dest: '<%= path.public %>/assets/img'
        ]
      jpg:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.{jpg,jpeg}'
          dest: '<%= path.public %>/assets/img'
          ext: '.jpg'
        ]
      png:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.png'
          dest: '<%= path.public %>/assets/img'
        ]
      svg:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/img'
          src: '**/*.svg'
          dest: '<%= path.public %>/assets/img'
        ]
      js:
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/js'
          src: '**/*.js'
          dest: '<%= path.public %>/assets/js'
        ]

    # HTMLmin - Minify HTML files
    # ------------------------------------------------------------------------ #
    htmlmin:
      templates:
        options:
          removeComments: true
          collapseWhitespace: true
        files: [
          expand: true
          cwd: '<%= path.dev %>/templates'
          src: '**/*.html'
          dest: '<%= path.craft %>/templates'
        ]
    svgstore:
      options:
        prefix : 'shape-', # This will prefix each ID
        svg:  # will add and overide the the default xmlns="http://www.w3.org/2000/svg" attribute to the resulting SVG
          style: "display:none;"

      default:
        files:
          "dev/assets/img/shapes.svg":["dev/assets/img/svgs/*.svg"]

    # Sass - CSS preprocessing
    # ------------------------------------------------------------------------ #
    sass:
      options:
        loadPath: ['bower','<%= path.dev %>/assets/css']
        style: 'compressed'
      styles:
        options:
          compass: true
        files: [
          expand: true
          cwd: '<%= path.dev %>/assets/css'
          src: [
            '**/*.{sass,scss}'
            '!**/_*.{sass,scss}'
          ]
          dest: '<%= path.public %>/assets/css'
          ext: '.css'
        ]

    # Uglify - JS compression
    # ------------------------------------------------------------------------ #
    uglify:
      options:
        compress:
          drop_console: false
        preserveComments: false
      scripts:
        files: '<%= path.public %>/assets/js/scripts.min.js': [
          '<%= path.public %>/assets/js/lib/jquery.js'
          '<%= path.public %>/assets/js/scripts.js'
        ]

    # HAML preprocessing for html, rss and xml
    # ------------------------------------------------------------------------ #
    haml:
      html:
        options:
          target: 'twig'
          enableDynamicAttributes: false
        files: [
          expand: true
          cwd: '<%= path.dev %>'
          src: ['templates/**/*.html.haml']
          dest: '<%= path.craft %>'
          ext: '.html'
        ]
      rss:
        options:
          target: 'twig'
          enableDynamicAttributes: false
        files: [
          expand: true
          cwd: '<%= path.dev %>'
          src: ['templates/**/*.rss.haml']
          dest: '<%= path.craft %>'
          ext: '.rss'
        ]
      xml:
        options:
          target: 'twig'
          enableDynamicAttributes: false
        files: [
          expand: true
          cwd: '<%= path.dev %>'
          src: ['templates/**/*.xml.haml']
          dest: '<%= path.craft %>'
          ext: '.xml'
        ]

    # CSS - Bless for splitting the file for IE
    # ------------------------------------------------------------------------ #
    bless:
      css:
        options:
          cacheBuster: false,
          compress: true
        files: 'content/assets/css/blessed-style.css': 'content/assets/css/style.css'

    # Deployments - FTP the template and asset files
    # ------------------------------------------------------------------------ #
    'ftp-deploy':
      templates:
        auth:
          host: 'ftp.theneurocore.com'
          port: 21
          authKey: 'rackspace'

        src: 'craft/templates'
        dest: '/blog.theneurocore.com/web/craft/templates'
        exclusions: [
          'craft/templates/**/.DS_Store'
          'craft/templates/**/Thumbs.db'
          'craft/templates/tmp'
        ]
      assets:
        auth:
          host: 'ftp.theneurocore.com'
          port: 21
          authKey: 'rackspace'

        src: 'content'
        dest: '/blog.theneurocore.com/web/content'
        exclusions: [
          'content/**/.DS_Store'
          'content/**/Thumbs.db'
          'content/tmp'
        ]

    # Deployments - Push/pull the DB
    # ------------------------------------------------------------------------ #
    deployments:
      options:
        'backups_dir': './backups'
        'target': 'production'
      'local': '<%= db.local %>'
      'production': '<%= db.production %>'

    shell:
      makeDb:
        options: failOnError: false
        command: 'mysql -u root -proot -e "create database 844961_craft" --socket=/Applications/MAMP/tmp/mysql/mysql.sock'

    # Watch - Run tasks when files are modified
    # ------------------------------------------------------------------------ #
    watch:

      options:
        livereload: true

      # Gruntfile
      grunt:
        files: [
          'Gruntfile.{coffee,js}'
          'config.rb'
        ]

      # Templates
      templates:
        files: ['<%= path.dev %>/templates/**/*']
        tasks: ['haml:html','haml:rss','haml:xml']

      # Scripts
      scripts:
        files: ['<%= path.dev %>/assets/js/*']
        tasks: [
          'coffee',
          'copy:js',
          'concat:jquery',
          'concat:dist',
          'uglify'
        ]

      # Styles
      styles:
        files: [
          '<%= path.dev %>/assets/css/**/*'
        ]
        tasks: ['sass:styles','bless:css']

      # Images
      img_gif:
        files: ['<%= path.dev %>/assets/img/**/*.gif']
        tasks: ['newer:copy:gif']
      img_jpg:
        files: ['<%= path.dev %>/assets/img/**/*.{jpg,jpeg}']
        tasks: ['newer:copy:jpg']
      img_png:
        files: ['<%= path.dev %>/assets/img/**/*.png']
        tasks: ['newer:copy:png']
      img_svg:
        files: ['<%= path.dev %>/assets/img/**/*.svg']
        tasks: ['svgstore','newer:copy:svg']

  # -------------------------------------------------------------------------- #
  # Load all Grunt tasks
  # -------------------------------------------------------------------------- #
  require('load-grunt-tasks')(grunt)

  # -------------------------------------------------------------------------- #
  # Build tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'build', [

    # Start off with a blank slate
    'clean'

    # Generate haml
    'haml:html'
    'haml:rss'
    'haml:xml'
    # Minimize templates and copy to Craft folder
    'htmlmin:templates'

    # Generate images
    'svgstore'
    'copy:gif'
    'copy:jpg'
    'copy:png'
    'copy:svg'

    # Generate scripts
    'coffee'
    'copy:js'
    'concat:jquery'
    'concat:dist'
    'uglify:scripts'

    # Generate styles
    'sass'
    'bless:css'

  ]

  # -------------------------------------------------------------------------- #
  # Deployment task
  # -------------------------------------------------------------------------- #
  grunt.task.registerTask 'db-pull', [
    'db_pull'
  ]
  grunt.task.registerTask 'db-setup', [
    'shell:makeDb'
    'db_pull'
  ]
  grunt.task.registerTask 'deploy', [
    'ftp-deploy:templates'
    'ftp-deploy:assets'
  ]
  grunt.task.registerTask 'deploy-templates', [
    'ftp-deploy:templates'
  ]
  grunt.task.registerTask 'deploy-assets', [
    'ftp-deploy:assets'
  ]
  # -------------------------------------------------------------------------- #
  # Listen tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'listen', [

    # Watch dev files for changes
    'watch'
  ]

  # -------------------------------------------------------------------------- #
  # Default tasks
  # -------------------------------------------------------------------------- #
  grunt.registerTask 'default', ['build', 'listen']

  return
