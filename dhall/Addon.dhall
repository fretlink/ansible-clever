let Addon = < Postgresql : { name : Text, env_prefix : Text } >

let postgresql =
      Addon.Postgresql { name = "pg", env_prefix = "POSTGRESQL_ADDON" }

in  { Type = Addon, postgresql = postgresql }
