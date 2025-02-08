#!/bin/bash
# 该脚本用于 Fail2ban 事件通知，并通过 Telegram 发送告警信息。

# 显示使用方法
function show_usage {
  echo "用法: $0 {start|stop|ban|unban} [IP]"
  echo "封禁 和 解封 需要提供 IP 地址"
  exit 1
}

# 发送 Telegram 消息
function send_msg {
  local apiToken=<put your api key here> # 你的 API Key
  local chatId=<put your chat id here> # 你的 Chat ID
  local url="https://api.telegram.org/bot$apiToken/sendMessage" # 国外
  # local url="https://tg.19981115.xyz/bot$apiToken/sendMessage" # 国内使用代理

  # 进行 URL 编码以支持换行
  local encoded_msg=$(echo -e "$1" | sed ':a;N;$!ba;s/\n/%0A/g')

  curl -s -X POST "${url}" \
       -d chat_id="${chatId}" \
       -d text="${encoded_msg}" \
       -d parse_mode="MarkdownV2" >/dev/null
}

# 检查参数
if [ $# -lt 1 ]; then
  show_usage
fi

# 获取当前时间和服务器 IP
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
server_ip=$(curl -s https://ifconfig.me)  # 获取IP

# 处理不同操作
case "$1" in
  start)
    msg="🚀 *[Fail2ban 服务通知]*%0A%0A✅ *服务已启动*%0A📅 时间: \`${timestamp}\`%0A🌐 服务器 IP: \`${server_ip}\`"
    send_msg "$msg"
    ;;
  stop)
    msg="⚠️ *[Fail2ban 服务通知]*%0A%0A⛔ *服务已停止*%0A📅 时间: \`${timestamp}\`%0A🌐 服务器 IP: \`${server_ip}\`"
    send_msg "$msg"
    ;;
  ban)
    if [ -n "$2" ]; then
      ip="$2"
    else
      ip="未知 IP"
    fi
    msg="🚨 *[Fail2ban 警报]*%0A%0A🚫 *封禁事件*%0A📅 时间: \`${timestamp}\`%0A🌐 服务器 IP: \`${server_ip}\`%0A🚷 封禁的 IP: \`${ip}\`"
    send_msg "$msg"
    ;;
  解封)
    if [ -n "$2" ]; then
      ip="$2"
    else
      ip="未知 IP"
    fi
    msg="✅ *[Fail2ban 通知]*%0A%0A🔓 *解封事件*%0A📅 时间: \`${timestamp}\`%0A🌐 服务器 IP: \`${server_ip}\`%0A🔄 解封的 IP: \`${ip}\`"
    send_msg "$msg"
    ;;
  *)
    show_usage
    ;;
esac
