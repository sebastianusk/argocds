{
  generate(input):: {
    apiVersion: 'v1',
    kind: 'Secret',
    metadata: {
      name: input.name + '-microservice',
      annotations: {
        rollme: '50VqV7zMKcUsAwkcFojIL5artduiDL0R',
      },
    },
    type: 'Opaque',
    stringData: input.secrets,
  },
}
