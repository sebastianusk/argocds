local base = import '../base/base.libsonnet';

[
  base.actionRunner('android', { memory: '8Gi', cpu: '4000m' }) + {},
  base.runnerScaler('android') + {},
]
