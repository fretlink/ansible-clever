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
          Text
      , clever_domain :
          Text
      , clever_app_tasks_file :
          Text
      , clever_entry_point :
          Text
      , clever_metrics :
          Bool
      , clever_addons :
          List Addon
      , clever_env :
          Environment
      }
