let ServiceDependency =
      < Addon : { addon_id : Text } | Application : { app_id : Text } >

let addon = λ(addon_id : Text) → ServiceDependency.Addon { addon_id = addon_id }

let application =
      λ(app_id : Text) → ServiceDependency.Application { app_id = app_id }

in  { Type = ServiceDependency, addon = addon, application = application }
