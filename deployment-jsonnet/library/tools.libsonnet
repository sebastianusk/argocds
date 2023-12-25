{
  generateMetadata(input)::
    {
      'app.kubernetes.io/name': 'microservice',
      'app.kubernetes.io/instance': input.name,
      'app.kubernetes.io/component': input.component,
      'kubecost.team': input.team,
      'kubecost.app': input.name,
    },
  generateDatadog(input):: '{"component":"%s","project":"%s","team":"%s"}' %
                           [input.component, input.project, input.team],
}
