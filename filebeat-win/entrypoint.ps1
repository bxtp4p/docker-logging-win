Set-Location "C:\Program Files\Filebeat"; 

#Environment variable replacement isn't happening for some reason on Windows so here's a manual way to do it.
$configfile = "filebeat.yml";
(Get-Content $configfile).Replace('${LOGSTASH_HOSTS}',$env:LOGSTASH_HOSTS).Replace('${DOCKER_HOST}', $env:DOCKER_HOST).Replace('${KIBANA_HOST}', $env:KIBANA_HOST) | Set-Content $configfile;

.\filebeat.exe  setup --template -E output.logstash.enabled=false -E output.elasticsearch.hosts=[$env:ES_HOSTS];

# Start the service
Start-Service "filebeat";
while ((Get-Service filebeat).Status -eq "Running") {
  Get-Content C:\ProgramData\Filebeat\logs\filebeat -Tail 1;
  Start-Sleep -Seconds 30; 
}