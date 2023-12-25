local templates = import '../../library/library.libsonnet';
// Load the contents of the YAML file as a string
local yamlStr = importstr 'values.yaml';
// Parse the YAML string into a Jsonnet object
local values = std.parseYaml(yamlStr);

templates.generate(values)
