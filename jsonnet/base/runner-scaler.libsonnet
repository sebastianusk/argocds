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
}
