local deployment = import 'deployment.libsonnet';

{
  generate(input)::
    [
      deployment.generate(input),
    ],
}
