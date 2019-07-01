let Config = ./Config.dhall

let Vault = ./Vault.dhall

let Addon = ./addon/Addon.dhall

let nonifyEmpty =
        λ(opt : Optional Text)
      → Optional/fold Text opt Text (λ(x : Text) → x) "None"

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
            nonifyEmpty syslogServer
        , clever_domain =
            nonifyEmpty domain
        , clever_app_tasks_file =
            nonifyEmpty tasksFile
        , clever_haskell_entry_point =
            nonifyEmpty entryPoint
        , clever_metrics =
            metrics
        , clever_addons =
            addons
        , clever_env =
            {=}
        }
      : Config {}
