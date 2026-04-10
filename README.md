# changedetection

Website change monitoring using [changedetection.io](https://github.com/dgtlmoon/changedetection.io).

## Infrastructure

| | |
|---|---|
| **Instance** | t3.micro, us-east-1a |
| **IP** | 44.199.236.90 |
| **URL** | http://44.199.236.90:5000 |
| **Key** | `~/resy-sniper/resy-sniper.pem` |
| **User** | `ec2-user` |
| **Security Group** | `sg-0ae7b090b1f2e83aa` |

## Setup

```bash
# SSH in
ssh -i ~/resy-sniper/resy-sniper.pem ec2-user@44.199.236.90

# Run setup script
chmod +x setup.sh && ./setup.sh
```

## Notifications

Email alerts via AWS SES SMTP to `james@1nessagency.com`.

- **From:** `james@plocamium.ventures`
- **SMTP host:** `email-smtp.us-east-1.amazonaws.com:587`
- **IAM user:** `changedetection-ses` (account 216890068001)

Notification URL and password hash are stored in `./data/changedetection.json` on the instance (not committed).

## Access

Port 5000 is restricted to a specific IP in the security group. If your IP changes:

```bash
# Add new IP
aws ec2 authorize-security-group-ingress --group-id sg-0ae7b090b1f2e83aa \
  --protocol tcp --port 5000 --cidr <your-ip>/32

# Remove old IP
aws ec2 revoke-security-group-ingress --group-id sg-0ae7b090b1f2e83aa \
  --protocol tcp --port 5000 --cidr <old-ip>/32
```

## Data

Watches, history, and config are persisted in `./data` (mapped to `/datastore` in the container).
