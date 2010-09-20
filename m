From: Guillaume Chazarain <guichaz@gmail.com>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 11:43:38 +0200
Message-ID: <AANLkTi=1zh4hD-1uzpgjAsnKZBE=qi_ZAX-ug=2XMkW0@mail.gmail.com>
References: <4C96B9DB.8030403@turmel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35760 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab0ITJnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 05:43:40 -0400
In-Reply-To: <4C96B9DB.8030403@turmel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Phil Turmel <philip@turmel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Mat <jackdachef@gmail.com>, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>

[ + Mat <jackdachef@gmail.com>, Andreas Bombe <aeb@debian.org>, Alex
Riesen <raa.lkml@gmail.com> ]

On Mon, Sep 20, 2010 at 3:33 AM, Phil Turmel <philip@turmel.org> wrote:
> A new regression was introduced between -rc3 and -rc4:
>
> The USB mouse I use with my laptop is causing a BUG when inserted. =C2=
=A0It works at that
> point, but if removed and re-inserted, it is ignored. =C2=A0Also, aft=
er the 2nd insert,
> other USB devices (like my thumb drive) are also ignored.
>
> [ =C2=A0 37.450777] BUG: unable to handle kernel NULL pointer derefer=
ence at (null)
> [ =C2=A0 37.451148] IP: [<ffffffff817d0991>] hiddev_open+0xc1/0x220
> [ =C2=A0 37.452036] PGD 1131a0067 PUD 113036067 PMD 0
> [ =C2=A0 37.452924] Oops: 0000 [#1] PREEMPT SMP
> [ =C2=A0 37.453336] last sysfs file: /sys/devices/platform/toshiba_ac=
pi/backlight/toshiba/max_brightness
> [ =C2=A0 37.453336] CPU 1
> [ =C2=A0 37.453336] Modules linked in: tpm_infineon iwlagn iwlcore ti=
fm_7xx1 tpm_tis toshiba_bluetooth toshiba_acpi tifm_core pcmcia sdhci_p=
ci yenta_socket sdhci [last unloaded: scsi_wait_scan]
> [ =C2=A0 37.453336]
> [ =C2=A0 37.453336] Pid: 3117, comm: hald-probe-hidd Not tainted 2.6.=
36-rc4-00166-g151b6a5 #28 Portable PC/TECRA A9
> [ =C2=A0 37.453336] RIP: 0010:[<ffffffff817d0991>] =C2=A0[<ffffffff81=
7d0991>] hiddev_open+0xc1/0x220
> [ =C2=A0 37.453336] RSP: 0018:ffff8801130e7c28 =C2=A0EFLAGS: 00010286
> [ =C2=A0 37.453336] RAX: 00000000ffffffed RBX: ffff8801121a0000 RCX: =
0000000000000000
> [ =C2=A0 37.453336] RDX: 0000000000000000 RSI: ffffffff81cfbfaa RDI: =
ffff8801121ac030
> [ =C2=A0 37.453336] RBP: ffff8801130e7c58 R08: 0000000000000010 R09: =
0000000000000000
> [ =C2=A0 37.453336] R10: 0000000000000000 R11: 0000000000000000 R12: =
ffff8801131c10c0
> [ =C2=A0 37.453336] R13: 0000000000000000 R14: 00000000ffffffed R15: =
ffff88013820ac68
> [ =C2=A0 37.453336] FS: =C2=A000007f3987315700(0000) GS:ffff880002500=
000(0000) knlGS:0000000000000000
> [ =C2=A0 37.453336] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
> [ =C2=A0 37.453336] CR2: 0000000000000000 CR3: 0000000112188000 CR4: =
00000000000006e0
> [ =C2=A0 37.453336] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ =C2=A0 37.453336] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: =
0000000000000400
> [ =C2=A0 37.453336] Process hald-probe-hidd (pid: 3117, threadinfo ff=
ff8801130e6000, task ffff8801399186b0)
> [ =C2=A0 37.453336] Stack:
> [ =C2=A0 37.453336] =C2=A0ffff8801130e6000 00000000000000b4 ffff88011=
31c10c0 ffffffff81b57c20
> [ =C2=A0 37.453336] <0> ffffffff81b66420 00000000ffffffed ffff8801130=
e7c98 ffffffff8171794b
> [ =C2=A0 37.453336] <0> 000000000029d5f6 ffff88013b345d00 ffff8801382=
0ac68 ffff8801131c10c0
> [ =C2=A0 37.453336] Call Trace:
> [ =C2=A0 37.453336] =C2=A0[<ffffffff8171794b>] usb_open+0x10b/0x2b0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81156ae0>] ? chrdev_open+0x0/0x28=
0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81156c07>] chrdev_open+0x127/0x28=
0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81156ae0>] ? chrdev_open+0x0/0x28=
0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81151508>] __dentry_open+0x108/0x=
3a0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff811518b4>] nameidata_to_filp+0x54=
/0x70
> [ =C2=A0 37.453336] =C2=A0[<ffffffff8115f668>] do_last+0x3b8/0x6c0
> [ =C2=A0 37.453336] =C2=A0[<ffffffff811618a8>] do_filp_open+0x228/0x6=
70
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81919ac5>] ? T.827+0x135/0x230
> [ =C2=A0 37.453336] =C2=A0[<ffffffff8116c4aa>] ? alloc_fd+0xfa/0x140
> [ =C2=A0 37.453336] =C2=A0[<ffffffff811512c5>] do_sys_open+0x65/0x130
> [ =C2=A0 37.453336] =C2=A0[<ffffffff811513d0>] sys_open+0x20/0x30
> [ =C2=A0 37.453336] =C2=A0[<ffffffff81037c1b>] system_call_fastpath+0=
x16/0x1b
> [ =C2=A0 37.453336] Code: 30 c0 00 00 48 c7 c6 aa bf cf 81 e8 9a 7d 8=
d ff 4c 89 ab 18 c0 00 00 b8 ed ff ff ff 49 89 9c 24 98 00 00 00 48 8b =
93 18 c0 00 00 <44> 8b 02 45 85 c0 0f 84 a8 00 00 00 8b 42 04 8d 48 01 =
85 c0 89
> [ =C2=A0 37.453336] RIP =C2=A0[<ffffffff817d0991>] hiddev_open+0xc1/0=
x220
> [ =C2=A0 37.453336] =C2=A0RSP <ffff8801130e7c28>
> [ =C2=A0 37.453336] CR2: 0000000000000000
> [ =C2=A0 37.495310] ---[ end trace a76b3a74914412d8 ]---
>
> I bisected this phenomenon to:
>
> 8fe294caf8c868edd9046251824a0af91991bf43 is the first bad commit
> commit 8fe294caf8c868edd9046251824a0af91991bf43
> Author: Guillaume Chazarain <guichaz@gmail.com>
> Date: =C2=A0 Sun Sep 12 21:32:35 2010 +0200
>
> =C2=A0 =C2=A0HID: fix hiddev's use of usb_find_interface
>
> =C2=A0 =C2=A0My macbook infrared remote control was broken by commit
> =C2=A0 =C2=A0bd25f4dd6972755579d0ea50d1a5ace2e9b00d1a ("HID: hiddev: =
use
> =C2=A0 =C2=A0usb_find_interface, get rid of BKL").
>
> =C2=A0 =C2=A0This device appears in dmesg as:
> =C2=A0 =C2=A0apple 0003:05AC:8242.0001: hiddev0,hidraw0: USB HID v1.1=
1 Device
> =C2=A0 =C2=A0[Apple Computer, Inc. IR Receiver] on usb-0000:00:1d.2-1=
/input0
>
> =C2=A0 =C2=A0It stopped working as lircd was getting ENODEV when open=
ing /dev/usb/hiddev0.
>
> =C2=A0 =C2=A0AFAICS hiddev_driver is a dummy driver so usb_find_inter=
face(&hiddev_driver)
> =C2=A0 =C2=A0does not find anything.
>
> =C2=A0 =C2=A0The device is associated with the usbhid driver, so let'=
s do
> =C2=A0 =C2=A0usb_find_interface(&hid_driver) instead.
>
> =C2=A0 =C2=A0$ ls -l /sys/devices/pci0000:00/0000:00:1d.2/usb7/7-1/7-=
1:1.0/usb/hiddev0/device/driver
> =C2=A0 =C2=A0lrwxrwxrwx 1 root root 0 2010-09-12 16:28 /sys/devices/p=
ci0000:00/0000:00:1d.2/usb7/7-1/7-1:1.0/usb/hiddev0/device/driver -> ..=
/../../../../../bus/usb/drivers/usbhid
>
> =C2=A0 =C2=A0Signed-off-by: Guillaume Chazarain <guichaz@gmail.com>
> =C2=A0 =C2=A0Signed-off-by: Jiri Kosina <jkosina@suse.cz>
>
> :040000 040000 a7db28b9b84792aa51a1027daebb627150892837 84209dde8d0d2=
ef3c1d58a20586060947890fc80 M =C2=A0 =C2=A0 =C2=A0drivers
>
> lsusb also gets stuck like so:
>
> # cat /proc/4306/stack
> [<ffffffff81719e3c>] usbdev_open+0x11c/0x2e0
> [<ffffffff81156c07>] chrdev_open+0x127/0x280
> [<ffffffff81151508>] __dentry_open+0x108/0x3a0
> [<ffffffff811518b4>] nameidata_to_filp+0x54/0x70
> [<ffffffff8115f668>] do_last+0x3b8/0x6c0
> [<ffffffff811618a8>] do_filp_open+0x228/0x670
> [<ffffffff811512c5>] do_sys_open+0x65/0x130
> [<ffffffff811513d0>] sys_open+0x20/0x30
> [<ffffffff81037c1b>] system_call_fastpath+0x16/0x1b
> [<ffffffffffffffff>] 0xffffffffffffffff
>
> The commit 8fe294c reverts cleanly from 2.6.36-rc4-00166-g151b6a5, an=
d solves this
> problem.
>
> Config, dmesg, and lsusb (after revert) are attached.
>
> The system is Gentoo unstable 64bit, w/ hal-0.5.14-r2 and udev-161.
>
> I'm happy to test patches in lieu of a revert, since it was a fix to =
a
> different regression.

One difference between the regression I originally reported and the
current one is that I was using the "apple" hid_driver while all the
regressions caused by my patch use the "generic" hid_driver.
Can you send the output of 'sudo ls -lR /sys | bzip2'?

Thanks.

--=20
Guillaume
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
