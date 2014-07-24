module.exports = (grunt) ->

  # Loads all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    meta:
      banner:
        '/* <%= pkg.name %> \n' +
        ' * version: <%= pkg.version %>\n' +
        ' * project: <%= pkg.project %>\n' +
        ' * update: <%= grunt.template.today(\'yyyy-mm-dd\") %>\n' +
        ' * Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author.name %> <<%=pkg.author.email%>>; \n' +
        ' */\n\n'

    clean:
      dist: ['dist/*']

    copy:
      img:
        expand: true,
        cwd: 'src/img',
        src: ['**'],
        dest: 'dist/img'

    requirejs:
      dist:
        options:
          mainConfigFile: 'src/app.js'
          name: 'app'
          out: 'dist/js/app.min.js'
          preserveLicenseComments: false

    connect:
      src:
        options:
          port: 3001
          base: 'src/'

    less:
      src:
        options:
          strictImports: false
        files:
          'src/css/app.css': 'src/less/app.less'
      dist:
        options:
          strictImports: false
          cleancss: true
          report: 'min'
        files:
          'dist/css/app.min.css': 'src/less/app.less'

    watch:
      src:
        files: ['src/less/**/*.less']
        tasks: ['less:src']

    jshint:
      options:
        jshintrc: '.jshintrc'
        reporter: require('jshint-stylish')
      all: ['src/js/*']

  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'dev', ['less:src', 'connect:src', 'watch:src']
  grunt.registerTask 'test', ['jshint']
  grunt.registerTask 'dist', ['clean', 'requirejs', 'less:dist', 'copy']

