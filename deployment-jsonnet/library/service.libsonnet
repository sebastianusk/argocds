{
  generate(input):: {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: input.name + '-microservice',
    },
    spec: {
      type: 'ClusterIP',
      ports: [
        {
          port: port,
          targetPort: 'http',
          protocol: 'TCP',
          name: 'http',
        }
        for port in input.ports
      ],
      selector: {
        'app.kubernetes.io/name': 'microservice',
        'app.kubernetes.io/instance': input.name,
      },
    },
  },
}
