# Capabilities of the Downward API

The following information is available to containers through environment variables and downwardAPI volumes:

## Information available via fieldRef:

metadata.name - the pod’s name
metadata.namespace - the pod’s namespace
metadata.uid - the pod’s UID
metadata.labels['<KEY>'] - the value of the pod’s label <KEY> (for example, metadata.labels['mylabel'])
metadata.annotations['<KEY>'] - the value of the pod’s annotation <KEY> (for example, metadata.annotations['myannotation'])

## Information available via resourceFieldRef:

A Container’s CPU limit
A Container’s CPU request
A Container’s memory limit
A Container’s memory request
A Container’s hugepages limit (providing that the DownwardAPIHugePages feature gate is enabled)
A Container’s hugepages request (providing that the DownwardAPIHugePages feature gate is enabled)
A Container’s ephemeral-storage limit
A Container’s ephemeral-storage request

## In addition, the following information is available through downwardAPI volume fieldRef:

metadata.labels - all of the pod’s labels, formatted as label-key="escaped-label-value" with one label per line
metadata.annotations - all of the pod’s annotations, formatted as annotation-key="escaped-annotation-value" with one annotation per line

## The following information is available through environment variables:

status.podIP - the pod’s IP address
spec.serviceAccountName - the pod’s service account name
spec.nodeName - the node’s name
status.hostIP - the node’s IP

### Note: If CPU and memory limits are not specified for a Container, the Downward API defaults to the node allocatable value for CPU and memory.
