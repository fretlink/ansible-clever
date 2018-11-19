    let addon = constructors ./Addon.dhall

in  addon.Postgresql { name = "pg", env_prefix = "POSTGRESQL_ADDON" }
