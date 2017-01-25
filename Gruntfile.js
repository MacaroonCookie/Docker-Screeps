module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-docker-io');
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    docker_io: {
      screeps: {
        options: {
          dockerFileLocation: 'dockerfile/Dockerfile',
          buildName: 'screeps',
          tag: 'latest',
          pushLocation: 'https://hub.docker.io',
          username: 'macarooncookie',
          push: true,
          force: false
        }
      }
    }
  })
}
