{
  generate(input):: {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: input.name + '-microservice',
    },
    data: input.configMap,
  },
}
