local tools = import 'tools.libsonnet';

{
  generate(input)::
    {
      apiVersion: 'apps/v1',
      kind: 'Deployment',
      metadata: {
        name: input.name + '-microservice',
        labels: tools.generateMetadata(input),
      },
      spec: {
        replicas: 1,
        revisionHistoryLimit: 1,
        strategy: {
          type: 'RollingUpdate',
        },
        progressDeadlineSeconds: 900,
        selector: {
          matchLabels: {
            'app.kubernetes.io/name': 'microservice',
            'app.kubernetes.io/instance': input.name,
          },
        },
        template: {
          metadata: {
            labels: tools.generateMetadata(input),
            annotations: {
              'ad.datadoghq.com/tags': tools.generateDatadog(input),
              rollme: '6XUkV',
            },
          },
          spec: {
            serviceAccountName: 'default',
            securityContext: {},
            containers: [
              {
                name: input.name + '-microservice',
                securityContext: {},
                image: input.image,
                imagePullPolicy: 'IfNotPresent',
                envFrom: [
                  {
                    configMapRef: {
                      name: input.name + '-microservice',
                    },
                  },
                  {
                    secretRef: {
                      name: input.name + '-microservice',
                    },
                  },
                ],
                ports: [
                  {
                    name: 'http',
                    containerPort: std.toString(port),
                    protocol: 'TCP',
                  }
                  for port in input.ports
                ],
                resources: {},
              },
            ],
            terminationGracePeriodSeconds: 30,
          },
        },
      },
    },
}
