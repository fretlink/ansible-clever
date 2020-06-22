let Addon = (./Addon.dhall).Type

let Vault = ./Vault.dhall

let FixedOrRange =
      λ(t : Type) → < Fixed : { fixed : t } | Range : { min : t, max : t } >

let fixed = λ(t : Type) → λ(f : t) → (FixedOrRange t).Fixed { fixed = f }

let range = λ(t : Type) → λ(r : { min : t, max : t }) → (FixedOrRange t).Range r

let InstancesConfig = FixedOrRange Natural

let FlavorsConfig = FixedOrRange Text

let ScalingParameters =
      { flavor : Optional FlavorsConfig, instances : Optional InstancesConfig }

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
        , clever_scaling : Optional ScalingParameters
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
          , clever_scaling = None ScalingParameters
          }
        : Config {}

in  { Type = Config
    , mkConfig = mkConfig
    , ScalingParameters = ScalingParameters
    , InstancesConfig = InstancesConfig
    , FlavorsConfig = FlavorsConfig
    , fixed = fixed
    , range = range
    }
