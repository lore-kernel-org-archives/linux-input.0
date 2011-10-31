From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: BUG: hid_add_device
Date: Tue, 1 Nov 2011 01:15:09 +0200
Message-ID: <CAOazyz3GEucTZNMDg7uyV6ZBBHWKC6ix4XA+3UO7LbRZ==J5mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37694 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934704Ab1JaXPK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Oct 2011 19:15:10 -0400
Received: by mail-qy0-f174.google.com with SMTP id 4so4438365qyk.19
        for <linux-input@vger.kernel.org>; Mon, 31 Oct 2011 16:15:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

While experimenting in bluetooth and DualShock3 controller and the
compat of bluez-4, I've found that only:
---
hidd --server --nocheck -n --nosdp
---

Reacts to the device, I don't know why the --nosdp has a difference,
but this is how far could go, in other cases, I get either:
---
Oct 31 23:39:11 localhost hidd[15164]: HID create error 4 (Interrupted
system call)
Oct 31 21:30:46 localhost hidd[26720]: HID create error 115 (Operation
now in progress)
---

However, while hidd tries to setup the device I get the fulling BUG:
(this I guess should not happen)
---
Oct 31 21:39:04 localhost hidd[8955]: Bluetooth HID daemon
Oct 31 21:39:17 localhost kernel: input: Bluetooth HID Boot Protocol
Device as /devices/pci0000:00/0000:00:1a.1/usb4/4-2/4-2:1.0/bluetooth/hci0/hci0:11/input15
Oct 31 21:39:17 localhost hidd[8955]: New HID device 00:26:5C:31:E2:79 ()
Oct 31 21:39:17 localhost kernel: BUG: unable to handle kernel paging
request at 0000000000001b00
Oct 31 21:39:17 localhost kernel: IP: [<ffffffffa03d7039>]
hid_add_device+0x9/0x200 [hid]
Oct 31 21:39:17 localhost kernel: PGD 0
Oct 31 21:39:17 localhost kernel: Oops: 0000 [#1] PREEMPT SMP
Oct 31 21:39:17 localhost kernel: CPU 1
Oct 31 21:39:17 localhost kernel: Modules linked in: uinput hidp hid
autofs4 bridge stp llc tun nf_nat_ftp nf_nat_irc nf_conntrack_ftp
nf_conntrack_irc ipt_MASQUERADE iptable_nat nf_nat ipt_REJECT
xt_tcpudp xt_state ipt_LOG xt_limit nf_conntrack_ipv4 nf_conntrack
nf_defrag_ipv4 iptable_filter ip_tables x_tables bnep ppp_generic slhc
cfq_iosched blk_cgroup ioatdma dca cpufreq_powersave cpufreq_ondemand
cpufreq_conservative acpi_cpufreq freq_table mperf coretemp fan
af_packet nls_cp1255 nls_iso8859_1 nls_utf8 rfcomm aes_x86_64
aes_generic ecb crypto_blkcipher btusb bluetooth uvcvideo videodev
cryptomgr aead arc4 crypto_algapi snd_hda_codec_conexant snd_hda_intel
snd_hda_codec iwlagn joydev thinkpad_acpi mac80211 snd_pcm snd_timer
uhci_hcd ehci_hcd sdhci_pci hwmon cfg80211 snd sdhci sr_mod battery
usbcore snd_page_alloc thermal psmouse pcspkr e1000e mmc_core
soundcore i2c_i801 cdrom processor ac rfkill rtc_cmos power_supply
nvram sg unix evdev ext4 crc16 jbd2 mbcache loop ahci libahci libata
sd_mod scsi_mod
Oct 31 21:39:17 localhost kernel:
Oct 31 21:39:17 localhost kernel: Pid: 8955, comm: hidd Not tainted
3.1.0-gentoo #1 LENOVO 406226U/406226U
Oct 31 21:39:17 localhost kernel: RIP: 0010:[<ffffffffa03d7039>]
[<ffffffffa03d7039>] hid_add_device+0x9/0x200 [hid]
Oct 31 21:39:17 localhost kernel: RSP: 0018:ffff8801358f3c48  EFLAGS: 00010296
Oct 31 21:39:17 localhost kernel: RAX: 0000000000000000 RBX:
0000000000000000 RCX: ffff88011a801368
Oct 31 21:39:17 localhost kernel: RDX: ffff88011a801368 RSI:
0000000000000212 RDI: 0000000000000000
Oct 31 21:39:17 localhost kernel: RBP: ffff88011a801360 R08:
0000000000000000 R09: 0000000000000000
Oct 31 21:39:17 localhost kernel: R10: 0000000000000000 R11:
0000000000000001 R12: ffff8801358f3c88
Oct 31 21:39:17 localhost kernel: R13: ffff880136f98000 R14:
ffff8801358f3ca0 R15: ffff880136f98000
Oct 31 21:39:17 localhost kernel: FS:  00007f18c7345700(0000)
GS:ffff88013bd00000(0000) knlGS:0000000000000000
Oct 31 21:39:17 localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
000000008005003b
Oct 31 21:39:17 localhost kernel: CR2: 0000000000001b00 CR3:
000000011abc1000 CR4: 00000000000006e0
Oct 31 21:39:17 localhost kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Oct 31 21:39:17 localhost kernel: DR3: 0000000000000000 DR6:
00000000ffff0ff0 DR7: 0000000000000400
Oct 31 21:39:17 localhost kernel: Process hidd (pid: 8955, threadinfo
ffff8801358f2000, task ffff880136f98000)
Oct 31 21:39:17 localhost kernel: Stack:
Oct 31 21:39:17 localhost kernel: 0000000000000212 ffffffff8105dc5a
ffff88011a801200 ffff88011a801200
Oct 31 21:39:17 localhost kernel: ffff88011a801360 ffffffffa0308bc5
0000000000000000 ffff880127b89800
Oct 31 21:39:17 localhost kernel: 0000000000000000 ffff880136f98000
ffffffff8105db00 ffff8801358f3ca0
Oct 31 21:39:17 localhost kernel: Call Trace:
Oct 31 21:39:17 localhost kernel: [<ffffffff8105dc5a>] ? finish_wait+0x3a/0x90
Oct 31 21:39:17 localhost kernel: [<ffffffffa0308bc5>] ?
hidp_add_connection+0x395/0x8c0 [hidp]
Oct 31 21:39:17 localhost kernel: [<ffffffff8105db00>] ? wake_up_bit+0x40/0x40
Oct 31 21:39:17 localhost kernel: [<ffffffffa03095a1>] ?
hidp_sock_ioctl+0x221/0x2e0 [hidp]
Oct 31 21:39:17 localhost kernel: [<ffffffff8113cae4>] ? fsnotify+0x1c4/0x2e0
Oct 31 21:39:17 localhost kernel: [<ffffffff811b98c0>] ? n_tty_ioctl+0xc0/0xc0
Oct 31 21:39:17 localhost kernel: [<ffffffff812ecc52>] ?
sockfd_lookup_light+0x22/0x90
Oct 31 21:39:17 localhost kernel: [<ffffffff812ee7cc>] ? sys_sendto+0x13c/0x1a0
Oct 31 21:39:17 localhost kernel: [<ffffffff81104254>] ?
do_readv_writev+0x1c4/0x210
Oct 31 21:39:17 localhost kernel: [<ffffffff812ec139>] ? sock_ioctl+0x69/0x2a0
Oct 31 21:39:17 localhost kernel: [<ffffffff811152e6>] ? do_vfs_ioctl+0x96/0x500
Oct 31 21:39:17 localhost kernel: [<ffffffffa02d7931>] ?
l2cap_sock_getsockopt+0xa1/0x340 [bluetooth]
Oct 31 21:39:17 localhost kernel: [<ffffffff811157e8>] ? sys_ioctl+0x98/0xa0
Oct 31 21:39:17 localhost kernel: [<ffffffff8138333b>] ?
system_call_fastpath+0x16/0x1b
Oct 31 21:39:17 localhost kernel: Code: 00 00 48 89 ef 48 c7 c3 f4 ff
ff ff e8 e1 07 ee e0 eb b6 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00
00 55 53 48 89 fb 48 83 ec 18 <f6> 87 00 1b 00 00 01 0f 85 c1 01 00 00
8b af 08 1b 00 00 f7 c5
Oct 31 21:39:17 localhost kernel: RIP  [<ffffffffa03d7039>]
hid_add_device+0x9/0x200 [hid]
Oct 31 21:39:17 localhost kernel: RSP <ffff8801358f3c48>
Oct 31 21:39:17 localhost kernel: CR2: 0000000000001b00
Oct 31 21:39:17 localhost kernel: ---[ end trace 326cc646c2b87b83 ]---
---
