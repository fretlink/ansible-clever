# ansible-clever

[![Build Status](https://travis-ci.com/fretlink/ansible-clever.svg?token=D3nFpUxMu7vStDHwUNy4&branch=master)](https://travis-ci.com/fretlink/ansible-clever)

Ansible role for Clever Cloud deployment
=======

This role deploys applications on clever cloud (https://www.clever-cloud.com).
It handles the publication over git, as well as configuring domain names, environment variables and log drains, dedicated build instances, and scalability parameters.

Requirements
------------

This role requires [`clever-tools`](https://github.com/CleverCloud/clever-tools) CLI version `2.6.1` or higher.

If you want to configure this role with [Dhall](https://dhall-lang.org/) instead of YAML, the role publishes dhall bindings defined in the `dhall/package.dhall` file. These bindings will need Dhall version `1.26.0` or higher.

Role Variables
--------------

Variables for the application:

- `clever_token`: clever_cloud token, **mandatory**.
- `clever_secret`: clever_cloud secret, **mandatory**.
- `clever_app`: the id of the app to link, **mandatory**.
- `clever_env`: a dict of environment variables to add to the application, optional.
- `clever_addons`: a list of dict describing addons enabled for the application from which we would use information during deploy, optional.<br/>
  Example: `{ name: pg, env_prefix: POSTGRESQL_ADDON }`
- `clever_app_tasks_file`: path to an Ansible tasks file to be executed after environment and addons variables where gathered. Specific to an application and should be use to run migrations for example. Optional.
- `clever_domain`: the domain from which the application should be reachable, optional.
- `clever_syslog_server`: UDP Syslog server to be used as UDPSyslog drain for the application, optional. Example: `udp://198.51.100.51:12345`.
- _Obsolete_: `clever_metrics`: metrics used to be disabled by default. Now they are enabled by default on Clever-Cloud and can be explicitly disabled with the `clever_disable_metrics` variable.
- `clever_disable_metrics`: a boolean to disable metrics support. Optional, default to `false`.
- `clever_env_output_file`: as a post deploy task you might need to retrieve the full Clever environment configuration (i.e. with addon env variables). If this variable is set to a filename then the env will be retrieved after a successful deploy and written to this file. Beware, the resulting file will contain sensitive information (addon passwords, …). Optional.
- `clever_build_flavor`: an optional text value used to configure the size of the dedicated build instance (for instance `S` or `XL`). If not defined, it delegates to clever cloud default behaviour. Setting `disabled` disables the dedicated build instance altogether.
- `clever_scaling`: an optional object used to configure the runtime instances flavours and numbers. If not defined, it delegates to clever cloud default behaviour.
- `clever_service_dependencies`: a list of the service dependencies needed by the application (each service being a dict containing either an `app_id` field, or an `addon_id` field), optional.<br/>
  Example: `[{ addon_id: addon_00000000-0000-0000-0000-000000000000 }, { app_id: app_00000000-0000-0000-0000-000000000000 }]`

Variables **specific to deployment**, defaults should be fine:

- `clever_app_root`: Path of the application to deploy, default to `app_root` if defined or `"{{ playbook_dir }}/.."` otherwise. I.e. the default behaviour will work fine if you define a playbook using this role within a directory (e.g. `deployment/` located at the root of the application.
- `clever_cli_version`: Version of clever cli tools, default to `2.6.1`.
- `clever_user_path`: Path relative to ansible_user home dir where cli tools and helpers are installed default to `.local/bin`.
- `clever_app_confdir`: Path where to store clever cloud data specific to this application, default to `"{{ clever_app_root }}/.clever_cloud"`
- `clever_login_file`: Path to store login information. Default to `"{{ clever_app_confdir }}/login"`.
- `clever_restart_only`: set to `true` to skip any deployment related tasks (domain, scaling, env, deploy, …) and only restart the application. Optional.

Variables specific to Haskell applications:

- `clever_haskell_entry_point`: the haskell executable name to be executed by clever cloud, optional.

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

This is the most basic usage of the role by specifying at least the clever app id and a clever token & secret pair.

    - hosts: localhost
      roles:
         - role: fretlink.clever,
           vars:
             clever_app: app_00000000-0000-0000-0000-000000000000,
             clever_token: "{{ vault_clever_token }}",
             clever_secret: "{{ vault_clever_secret}}"

If you only need a task to restart your clever application, this would be enough:

    - hosts: localhost
      roles:
         - role: fretlink.clever,
           vars:
             clever_app: app_00000000-0000-0000-0000-000000000000,
             clever_token: "{{ vault_clever_token }}",
             clever_secret: "{{ vault_clever_secret}}"
             clever_restart_only: true

Tests
----

The role is tested with automated continuous integration on Travis. Please check the `tests/` directory for other usage examples of this role.

License
-------

MIT (see LICENSE file for details)

Author Information
------------------

Developed at [Fretlink](https://tech.fretlink.com)
