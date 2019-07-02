let Addon = ./addon/Addon.dhall

in    λ(Environment : Type)
    → { clever_app :
          Text
      , clever_orga :
          Text
      , clever_secret :
          Text
      , clever_token :
          Text
      , clever_syslog_server :
          Optional Text
      , clever_domain :
          Optional Text
      , clever_app_tasks_file :
          Optional Text
      , clever_haskell_entry_point :
          Optional Text
      , clever_disable_metrics :
          Bool
      , clever_addons :
          List Addon
      , clever_env :
          Environment
      }
