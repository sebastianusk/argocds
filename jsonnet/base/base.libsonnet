{
  runnerScaler(name)::
    {
      apiVersion: 'actions.summerwind.dev/v1alpha1',
      kind: 'HorizontalRunnerAutoscaler',
      metadata:
        {
          name: name + '-runner-set-ci-autoscaler',
          namespace: 'actions-runner-system',
        },
      spec:
        {
          scaleDownDelaySecondsAfterScaleOut: 300,
          scaleTargetRef:
            { kind: 'RunnerSet', name: name + '-payfazz-org-ci-runner' },
          minReplicas: 1,
          maxReplicas: 150,
          metrics:
            [
              {
                type: 'PercentageRunnersBusy',
                scaleUpThreshold: '0.75',
                scaleDownThreshold: '0.25',
                scaleUpFactor: '2',
                scaleDownFactor: '0.5',
              },
            ],
        },

    },
  actionRunner(name, requests={})::
    {
      apiVersion: 'actions.summerwind.dev/v1alpha1',
      kind: 'RunnerSet',
      metadata:
        {
          name: name + '-payfazz-org-ci-runner',
          namespace: 'actions-runner-system',
        },
      spec:
        {
          organization: 'payfazz',
          replicas: 1,
          labels: [name],
          dockerdWithinRunnerContainer: true,
          ephemeral: true,
          serviceName: name + '-payfazz-org-ci-runner-set',
          selector:
            { matchLabels: { app: name + '-payfazz-org-ci-runner-set' } },
          template:
            {
              metadata:
                { labels: { app: name + '-payfazz-org-ci-runner-set' } },
              spec:
                {
                  volumes:
                    [
                      {
                        hostPath: { path: '/var/run/datadog' },
                        name: 'dsdsocket',
                      },
                    ],
                  containers:
                    [
                      {
                        name: 'runner',
                        image: 'summerwind/actions-runner-dind:ubuntu-20.04',
                        env:
                          [
                            {
                              name: 'POD_NAME',
                              valueFrom:
                                {
                                  fieldRef:
                                    {
                                      apiVersion: 'v1',
                                      fieldPath: 'metadata.name',
                                    },
                                },
                            },
                          ],
                        resources:
                          { requests: requests },
                        volumeMounts:
                          [
                            {
                              name: 'dsdsocket',
                              mountPath: '/var/run/datadog',
                              readOnly: true,
                            },
                            {
                              name: 'cache',
                              mountPath: '/runner/_work',
                              subPath: 'work',
                            },
                            {
                              name: 'cache',
                              mountPath: '/home/runner/.cache',
                              subPath: 'cache',
                            },
                            {
                              name: 'cache',
                              mountPath: '/home/runner/.local',
                              subPath: 'local',
                            },
                            {
                              name: 'cache',
                              mountPath: '/var/lib/buildkit',
                              subPath: 'buildkit',
                            },
                            {
                              name: 'cache',
                              mountPath: '/var/lib/docker',
                              subPath: 'docker',
                            },
                          ],
                      },
                    ],
                },
            },
          volumeClaimTemplates:
            [
              {
                metadata: { name: 'cache' },
                spec:
                  {
                    storageClassName: 'actions-runner-work',
                    accessModes: ['ReadWriteOnce'],
                    resources: { requests: { storage: '25Gi' } },
                  },
              },
            ],
        },
    },
}
