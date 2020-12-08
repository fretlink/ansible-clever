let Addon =
      < Postgresql : { name : Text, env_prefix : Text }
      | Mysql : { name : Text, env_prefix : Text }
      | Redis : { name : Text, env_prefix : Text }
      | MongoDB : { name : Text, env_prefix : Text }
      >

let postgresql =
      Addon.Postgresql { name = "pg", env_prefix = "POSTGRESQL_ADDON" }

let mysql = Addon.Mysql { name = "mysql", env_prefix = "MYSQL_ADDON" }

let redis = Addon.Redis { name = "redis", env_prefix = "REDIS" }

let mongodb = Addon.MongoDB { name = "mongodb", env_prefix = "MONGODB_ADDON" }

in  { Type = Addon, postgresql, mysql, redis, mongodb }
