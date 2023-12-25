{
  generate(input):: {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: input.name + '-microservice',
    },
    data: if std.objectHas(input, 'configMap') then input.configMap else {},
  },
}
