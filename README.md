# Fix Clash For Windows DNS Leak

## Introduction

- if you are working with Clash for windows and Tun mode, probably know that there is a DNS leak issue
  this issue is not the Clash problem and it's because windows sometimes send DNS queries through other Network Interfaces
- to fix this issue we can change the other network interfaces' DNS to Clash Tun Interface (usually changing the DNS of your main network interface card should be enough)

## Usage

- First Connect to a node using the Tun mode
- Run "Fix Clash Leak Dns.bat"
- then select your main network interface card
- then you can select the "Add DNS" option to set Clash DNS on your network interface

> When you turn off Tun Mode you can delete the DNS by running the bat file again and selecting the "Remove Dns" option
