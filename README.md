# fail2ban-telegram-notification

Send notification to telegram when fail2ban ban an IP address and unband an IP address

### Requirement

- openssh
- fail2ban
- curl
- telegram bot api

### Installation

`$ sudo apt install fail2ban`

### Configuration

#### Fail2ban

- Download and configure the `jail.conf ` file

  ```bash
  curl -sSL https://raw.githubusercontent.com/lovebai/fail2ban-telegram-notification/refs/heads/master/jail.conf -o /etc/fail2ban/jail.d/jail.conf
  ```
- Download `telegram.conf`

  ```bash
  curl -sSL https://raw.githubusercontent.com/lovebai/fail2ban-telegram-notification/refs/heads/master/telegram.conf -o /etc/fail2ban/action.d/telegram.conf
  ```
- Download `fail2ban-telegram.sh ` ，Create the `scripts` directory if it does not exist:

  ```bash
  mkdir -p /etc/fail2ban/scripts
  ```

  ```bash
  curl -sSL https://raw.githubusercontent.com/lovebai/fail2ban-telegram-notification/refs/heads/master/fail2ban-telegram.sh -o /etc/fail2ban/scripts/fail2ban-telegram.sh && chmod +x /etc/fail2ban/scripts/fail2ban-telegram.sh
  ```
- Edit fail2ban-telegram.sh and replace the `apiToken` and `chatId` with your api. You must create telegram bot first and get the api key [here](https://www.sohamkamani.com/blog/2016/09/21/making-a-telegram-bot/)

 Chinese users can use the proxy `https://gh.19981115.xyz/` ,just add this to the curl command, for example:

```bash
curl -sSL https://gh.19981115.xyz/https://raw.githubusercontent.com/lovebai/fail2ban-telegram-notification/refs/heads/master/jail.conf 
```

### Start the service

systemctl start fail2ban
