[![Build Status](https://travis-ci.org/juju4/ansible-scumblr.svg?branch=master)](https://travis-ci.org/juju4/ansible-scumblr)
# Scumblr ansible role

Ansible role to setup Netflix scumblr.
Scumblr is a web application that allows performing periodic searches and storing / taking actions on the identified results. Scumblr uses the Workflowable gem to allow setting up flexible workflows for different types of results.
* https://vimeo.com/113447971
* http://techblog.netflix.com/2014/08/announcing-scumblr-and-sketchy-search.html
* https://github.com/Netflix/Scumblr
It's build mostly for v1.1. v2 released oct 2016 had limited testing for now.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0

### Operating systems

Tested with vagrant only on Ubuntu 14.04 for now but should work on 12.04 and similar debian based systems.
More work is needed for redhat-based distribution or other Unix.

### Dependencies

Optional dependencies
- sketchy if you want to make web page capture
- nginx for a reverse-proxy (production setup)

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - scumblr
```

And connect at the end on http://IP:3000
Rails server is in development mode by default. Please check known issues.

To finish integration, you should
 - review extra dependencies like sketchy
 - register some API like ebay, facebook, google, youtube, twitter.
 - reference search request like
Dirty laundry: Automated review of edge systems
Septic Tank: Identification and actioning of credentials dumps
Social Media Chatter: review known "bad" accounts for company discussion
RSS Search provider: vulnerability
https://mig5.net/content/monitoring-pastebincom-scumblr
Google Hacking Database https://www.exploit-db.com/google-hacking-database/
COMPANY security
COMPANY leak
COMPANY vulnerability
COMPANY web mail
COMPANY torrent
websites hacked 0wned
denial of service, ddos
google news, reddit
public dropbox, google drive, hubic, spideroak, ...
documents search office/pdf, ...    http://www.pdfsearchengine.org/, http://www.findpdfdoc.com/, http://www.searchpdf.com/, ...
https://www.scribd.com/, http://fr.slideshare.net/, http://www.edocr.com/

See Scumblr guide at https://github.com/Netflix/Scumblr/wiki

## Variables

* scumblr_rails_user: default "{{ ansible_ssh_user }}". The user for scumblr rails application.
* scumblr_root: default /var/Scumblr. root path of rails app
* scumblr_rails_env: production
* scumblr_rails_webuser and webpass: root@localhost. Your default web user and password. Note that default insertion will fail as this email is seen as invalid by rails.

Other variables are also available for API key of Facebook, Google, Youtube and Twitter.

## Continuous integration

you can test this role with test kitchen.
In the role folder, run
```
$ cd /path/to/roles/scumblr
$ kitchen verify
$ kitchen login
```

Known bugs
* Ubuntu: the notify 'supervisor restart' fails the first time. not sure
  why. second time run is fine after you do ```sudo service supervisor restart```
  (failed notified handlers).

## FAQ

* scumblr configuration is stored in /var/Scumblr/db/development.sqlite3 (default)

## Troubleshooting & Known issues

* No additional security is provided. Review
http://guides.rubyonrails.org/security.html
https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet
http://blog.honeybadger.io/ruby-security-tutorial-and-rails-security-guide/
Recommended production setup include reverse proxy and eventually load balancing

* Backup/Restore script
https://gorails.com/guides/hourly-production-server-database-and-file-backups
DB and what?


* Monitoring
check process, http page
https://github.com/wanelo/nagios-checks/blob/master/check_sidekiq_queue


* Set up rails at boot
http://stackoverflow.com/questions/16932833/start-rails-server-automatically-after-reboot/23056985#23056985
w apache+passenger

* Browser redirect from IP:3000 to IP?

* devise requires Ruby version >= 2.1.0.
scumblr wiki recommends 2.0 w bundle command
forced version 3.5.7 against 4.0.0 (both Apr 2016)

* Scumblr v2: install is not functional
```
$ curl -sSq http://localhost:3000/
PG::UndefinedTable at /unauthenticated
======================================

> ERROR:  relation "sessions" does not exist
LINE 5:                WHERE a.attrelid = '"sessions"'::regclass
                                          ^


activerecord (4.2.6) lib/active_record/connection_adapters/postgresql_adapter.rb, line 592
------------------------------------------------------------------------------------------

ruby
  587             result.clear
  588             ret
  589           end
  590
  591           def exec_no_cache(sql, name, binds)
> 592             log(sql, name, binds) { @connection.async_exec(sql, []) }
  593           end

```

## License

BSD 2-clause

