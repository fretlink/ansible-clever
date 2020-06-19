let Addon = (./Addon.dhall).Type

let Vault = ./Vault.dhall

let Config =
        λ(Environment : Type)
      → { clever_app : Text
        , clever_orga : Text
        , clever_secret : Text
        , clever_token : Text
        , clever_syslog_server : Optional Text
        , clever_domain : Optional Text
        , clever_app_tasks_file : Optional Text
        , clever_haskell_entry_point : Optional Text
        , clever_disable_metrics : Bool
        , clever_addons : List Addon
        , clever_env : Environment
        , clever_build_flavor : Optional Text
        }

let mkConfig =
        λ(vault : Vault)
      → λ(app : Text)
      → λ(organization : Text)
      →   { clever_app = app
          , clever_orga = organization
          , clever_secret = vault.secret
          , clever_token = vault.token
          , clever_syslog_server = None Text
          , clever_domain = None Text
          , clever_app_tasks_file = None Text
          , clever_haskell_entry_point = None Text
          , clever_disable_metrics = False
          , clever_addons = [] : List Addon
          , clever_env = {=}
          , clever_build_flavor = None Text
          }
        : Config {}

in  { Type = Config, mkConfig = mkConfig }
