let Config = ./Config.dhall

let Vault = ./Vault.dhall

let Addon = ./addon/Addon.dhall

in    λ(vault : Vault)
    → λ(app : Text)
    → λ(organization : Text)
    → λ(entryPoint : Optional Text)
    → λ(metrics : Bool)
    → λ(syslogServer : Optional Text)
    → λ(domain : Optional Text)
    → λ(tasksFile : Optional Text)
    → λ(addons : List Addon)
    →   { clever_app =
            app
        , clever_orga =
            organization
        , clever_secret =
            vault.secret
        , clever_token =
            vault.token
        , clever_syslog_server =
            syslogServer
        , clever_domain =
            domain
        , clever_app_tasks_file =
            tasksFile
        , clever_haskell_entry_point =
            entryPoint
        , clever_metrics =
            metrics
        , clever_addons =
            addons
        , clever_env =
            {=}
        }
      : Config {}
