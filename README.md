# ansible-clever
Ansible role for clever cloud deployment
=======
Clever deploy
=========

This roles deploy an haskell app on clever cloud (https://www.clever-cloud.com).

Requirements
------------


Role Variables
--------------

Variables for the application
- `clever_token`: clever_cloud token, mandatory.
- `clever_secret`: clever_cloud secret, mandatory.
- `clever_app`: the id of the app to link, mandatory.
- `clever_entry_point`: the executable name to be executed by clever cloud, mandatory
- `clever_env`: a dict of environment variables for the application (without add_ons one already available), optional.
- `clever_base_env`: a dict set in vars/main.yml with safe default and mandatory variables for an app to be run on clever. ` clever_base_env | combine(clever_env)` is passed to `clever env` command
- `clever_addons`: a list of dict describing addons enabled for the application from which we would use information during deploy, optional.<br/>
  Example: `{ name: pg, env_prefix: POSTGRESQL_ADDON }`
- `clever_app_tasks_file`: tasks file to be executed after environment and addons variables where gathered. Specific to an app, should be use to run migrations. Optional.
- `domain`: the domain from which the application should be reachable, optional
- `syslog_server`: UDP Syslog server to be used as UDPSyslog drain for the application, optional. Example: `udp://198.51.100.51:12345`.
- `clever_metrics`: a boolean to enable or disable metrics support. Optional, default to `false`.

Variables specific to deployment, default should be fine:
- `clever_cli_version`: Version of clever cli tools, default to `0.9.3`.
- `clever_user_path`: Path relative to ansible_user home dir where cli tools and helpers are installed default to `.local/bin`.
- `clever_app_root`: Path of the application to deploy, default to `"{{ playbook_dir }}/.."`, ie ansible directory in the root of the application.
- `clever_app_confdir`: Path where to store clever cloud data specific to this application, default to `"{{ clever_app_root }}/.clever_cloud"`
- `clever_login_file`: Path to store login information. Default to `"{{ clever_app_confdir }}/login"`.


Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: fretlink.clever, clever_app: 42, clever_token: "{{ vault_clever_token }}", clever_secret: "{{ vault_clever_secret}}" }


TODO
----

Add some tests and Travis integration

License
-------

BSD

Author Information
------------------

Developped at Fretlink (https://www.fretlink.com) for our
