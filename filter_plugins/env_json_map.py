#!/usr/bin/env python

class FilterModule(object):
  def filters(self):
      return {'json_env_map': self.json_env_map}

  def json_env_map(self, env):
      return [{'name': k, 'value': str(v)} for k,v in env.items()]
