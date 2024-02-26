Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root
Disable-WindowsOptionalFeature -Online -FeatureName TFTP
Disable-WindowsOptionalFeature -FeatureName Internet-Explorer--Optional-amd64 -Online
Set-Service -StartupType Disabled seclogon
