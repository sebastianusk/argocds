local configmap = import 'configmap.libsonnet';
local deployment = import 'deployment.libsonnet';
local secret = import 'secret.libsonnet';
local service = import 'service.libsonnet';

{
  generate(input)::
    [
      deployment.generate(input),
      configmap.generate(input),
      secret.generate(input),
      service.generate(input),
    ],
}
