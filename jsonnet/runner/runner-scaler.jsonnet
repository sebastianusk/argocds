local base = import '../base/base.libsonnet';

[
  base.actionRunner('android') + {},
  base.runnerScaler('android') + {},
]
