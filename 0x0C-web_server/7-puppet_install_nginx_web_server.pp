#!/usr/bin/pup
# Nginx web server (w/ Puppet)
package { 'nginx':
  ensure => installed,
}
file { '/var/www/html/index.html':
  content => 'Hello World!',
}
file_line { 'default':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
}
file { '/var/www/html/error_404.html':
  content => 'Ceci n\'est pas une page',
}
file_line { 'error404':
  ensure => 'present',
  path   => '/etc/nginx/sites-available/default',
  after  => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  line   => 'error_page 404 /error_404.html;',
}
service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
