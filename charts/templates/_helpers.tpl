{{/*
Expand the name of the chart.
*/}}
{{- define "io.alexheld.site.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "io.alexheld.site.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "io.alexheld.site.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}



{{/*
Common Annotations
*/}}
{{- define "io.alexheld.site.annotations" -}}
helm.sh/chart: {{ include "io.alexheld.site.chart" . }}
{{ include "io.alexheld.site.selectorLabels" . }}
traefik.docker.network: {{ .Values.network.name | quote }}
traefik.enable: true
traefik.http.routers.website.entrypoints: {{ .Values.network.entryPoint | quote }}
traefik.http.routers.website.rule: {{ .Values.traefik.ruleQuery | quote }}
traefik.http.routers.website.service: {{ .Chart.Name | quote }}
traefik.http.routers.website.tls: true
traefik.http.routers.website.tls.certresolver: {{ .Values.certresolve | quote }}
traefik.http.services.website.loadbalancer.passhostheader: true
traefik.http.services.website.loadbalancer.server.port: {{ .Values.port }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion  }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ end -}}



{{/*
Common labels
*/}}
{{- define "io.alexheld.site.labels" -}}
helm.sh/chart: {{ include "io.alexheld.site.chart" . }}
{{ include "io.alexheld.site.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ end -}}




{{/*
Selector labels
*/}}
{{- define "io.alexheld.site.selectorLabels" -}}
app.kubernetes.io/name: {{ include "io.alexheld.site.name" . }}
app.kubernetes.io/instance: {{ .Release.Name | quote  }}
{{ end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "io.alexheld.site.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "io.alexheld.site.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}




{{- define "io.alexheld.site.traefikRuleQuery" -}}
{{- $traefikQuery := "" }}
{{- $urls := .Values.urls | quote }}
{{- $domainList := splitList "," $urls }}
{{- $length := len $domainList }}
{{- range $i, $domain := $domainList }}
  {{- if eq $i 0 -}}
      {{ $traefikQuery := printf "%s .." $domain }}
  {{- else -}}
      {{ $traefikQuery := printf "%s && Host(`$domain`)" $traefikQuery }}
  {{- end -}}
{{- end -}}

{{ print $traefikQuery }}

{{ end -}}