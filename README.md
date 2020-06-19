# ansible-clever

[![Build Status](https://travis-ci.com/fretlink/ansible-clever.svg?token=D3nFpUxMu7vStDHwUNy4&branch=master)](https://travis-ci.com/fretlink/ansible-clever)

Ansible role for clever cloud deployment
=======
Clever deploy
=========

This role deploys applications on clever cloud (https://www.clever-cloud.com).
It handles the publication over git, as well as domain names, environment variables and log drains configuration.

Requirements
------------

This role requires `clever-tools` version `2.6.1` or higher.

Role Variables
--------------

Variables for the application
- `clever_token`: clever_cloud token, mandatory.
- `clever_secret`: clever_cloud secret, mandatory.
- `clever_app`: the id of the app to link, mandatory.
- `clever_env`: a dict of environment variables for the application (without add_ons one already available), optional.
- `clever_base_env`: a dict set in vars/main.yml with safe default and mandatory variables for an app to be run on clever. ` clever_base_env | combine(clever_env)` is passed to `clever env` command
- `clever_addons`: a list of dict describing addons enabled for the application from which we would use information during deploy, optional.<br/>
  Example: `{ name: pg, env_prefix: POSTGRESQL_ADDON }`
- `clever_app_tasks_file`: tasks file to be executed after environment and addons variables where gathered. Specific to an app, should be use to run migrations. Optional.
- `clever_haskell_entry_point`: the haskell executable name to be executed by clever cloud, optional.
- `clever_domain`: the domain from which the application should be reachable, optional.
- _Obsolete_: `domain`: Same as above but was replaced by `clever_domain` since v1.4 of this role.
- `clever_syslog_server`: UDP Syslog server to be used as UDPSyslog drain for the application, optional. Example: `udp://198.51.100.51:12345`.
- _Obsolete_: `syslog_server`: Same as above but was replaced by `clever_syslog_server` since v1.5 of this role.
- _Obsolete_: `clever_metrics`: metrics used to be disabled by default. Now they are enabled by default and can be explicitly disabled with `clever_disable_metrics`.
- `clever_disable_metrics`: a boolean to disable metrics support. Optional, default to `false`.
- `clever_env_output_file`: as a post deploy task you might need to retrieve the full Clever environment configuration (i.e. with addon env variables). If this variable is set to a filename then the env will be retrieved after a successful deploy inside this file. Optional.
- `clever_build_flavor`: an optional text value used to configure the size of the dedicated build instance (for instance `S` or `XL`). If not defined, it delegates to clever cloud default behaviour. Setting `disabled` disables the dedicated build instance altogether.
- `clever_scaling`: an optional object used to configure the runtime instances flavours and numbers. If not defined, it delegates to clever cloud default behaviour.

Variables specific to deployment, default should be fine:
- `clever_cli_version`: Version of clever cli tools, default to `2.6.1`.
- `clever_user_path`: Path relative to ansible_user home dir where cli tools and helpers are installed default to `.local/bin`.
- `clever_app_root`: Path of the application to deploy, default to `app_root` if defined or `"{{ playbook_dir }}/.."`, ie ansible directory in the root of the application.
- `clever_app_confdir`: Path where to store clever cloud data specific to this application, default to `"{{ clever_app_root }}/.clever_cloud"`
- `clever_login_file`: Path to store login information. Default to `"{{ clever_app_confdir }}/login"`.

Scaling configuration
---------------------

```yaml
clever_scaling:
  # instances and flavors are optional and can be configured as
  # either a fixed value (with `fixed`) or a range # (with `min` and `max`)
  flavors:
    fixed: XS
  instances:
    min: 2
    max: 5
```


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
