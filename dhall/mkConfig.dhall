let Config = ./Config.dhall

let Vault = ./Vault.dhall

let Addon = ./addon/Addon.dhall

in    λ(vault : Vault)
    → λ(app : Text)
    → λ(organization : Text)
    →   { clever_app =
            app
        , clever_orga =
            organization
        , clever_secret =
            vault.secret
        , clever_token =
            vault.token
        , clever_syslog_server =
            None Text
        , clever_domain =
            None Text
        , clever_app_tasks_file =
            None Text
        , clever_haskell_entry_point =
            None Text
        , clever_disable_metrics =
            False
        , clever_addons =
            [] : List Addon
        , clever_env =
            {=}
        }
      : Config {}
