# Docker ELK + Filebeat for Windows

Sample ELK setup that includes Filebeat for Windows. This project sets up an ELK stack running in traditional Linux containers. This also adds Filebeat to the stack, hosted specifically in Windows containers.

The Windows Filebeat container reads the logs on the host through a bind mount of the containers directory (by default, `c:\programdata\docker\containers`).

To use this solution, clone or fork this repository. The Docker Compose file is intended to be a starting point. The Compose file uses the `node.labels.elkhost == true` placement constraint to determine what node to deploy the ELK components to. Either make sure to label one of your nodes to satisfy this constraint or adjust the constraint as necessary.

## Deploying the Stack
This stack can only be deployed from a Windows command prompt or Powershell. Due to a bug, the stack cannot be deployed through a Mac or Linux ([https://github.com/moby/moby/issues/34810](https://github.com/moby/moby/issues/34810)). To deploy:

```PowerShell
docker stack deploy -c docker-compose.yml elk
```
