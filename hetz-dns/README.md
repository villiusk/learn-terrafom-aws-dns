# Only Hetzner DNS
This only creates DNS records in Hetzner-DNS.
Auth to hcloud  used shell variable HCLOUD_TOKEN.

## State files saved on local minio
Authentication to minio is in .aws/credentials separate profile minio.
There main (default) AWS profile to create resources on AWS Cloud.
Addiotional profile garage was created to test garagehq for store state file. 
