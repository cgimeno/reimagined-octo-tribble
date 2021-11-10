# Statefulset
Statefulset was created using Helm. Helm was used as it allows to keep track easily of the deployed release, allows to create all the required resources in a single command and last but not least, allows to easily customize the statefulset using values.yaml file depending on the different environments.
Keep in mind that helm chart was created using

    helm create litecoin

So, some of the code was created by Helm, like the ingress or serviceaccount definition. They're nice to have but they won't be required for running litecoin

## Security
Again, security is one of the priorities when deploying something in Kubernetes. Statefulset manifest drops all capabilities as we don't really require them for running litecoin. Apart from that, pod won't be able to run as root, instead it will be ran using user id 1000, which is the same user id that was created on the Dockerfile

## Resilience
Of course the number of replicas can be easily updated on the values.yaml file. Apart from that, topologySpreadConstraints were added into the manifest. Using topologySpreadConstraints you can force kubernetes scheduler to schedule your pods in nodes that lives on different availability zones, ensuring that if there's an outage in one of them, you'll be able to survive using the remaining pods

Apart from that PodDisruptionBudget (PDB) was also added into the helm chart. PodDisruptionBudget are very important during cluster upgrades, as they won't allow Kubernetes scheduler to evict your pods for upgrading the pyshical node if the PDB is not met, ensuring that you'll have a minimum amount of pods always available.

## Monitoring
Just to briefly mention it even, a very common pattern when running a workload in Kubernetes is to ship logs to a central place, like Elasticsearch. Taking into account that the pod will be writing all the logging into the stdout, it's very easy using Logstash / filebeat / vector.dev to read them from there and ship to Elastic.

On the metrics part, litecoin doesn't provide any specific prometheus exporter. However, using [vector.dev](https://vector.dev/) it's very easy to parse the logs and create some metrics based on these logs.

If you are interested on knowing more about the topic, I wrote an article a few months ago, explaining how to do it. You can find it [here](https://medium.com/adidoescode/improving-your-observability-creating-metrics-from-your-logs-9ae8de9299f4)

