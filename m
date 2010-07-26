From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] INPUT: fix crash on setkeycode
Date: Mon, 26 Jul 2010 19:43:00 +0300
Message-ID: <1280162580.3492.20.camel@maxim-laptop>
References: <1280161278.3492.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42102 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab0GZQnF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 12:43:05 -0400
Received: by bwz1 with SMTP id 1so2890805bwz.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 09:43:03 -0700 (PDT)
In-Reply-To: <1280161278.3492.7.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Jarod Wilson <jarod@wilsonet.com>

On Mon, 2010-07-26 at 19:21 +0300, Maxim Levitsky wrote: 
> >From 69140692700821da1ff66e99d06322df6e7a4610 Mon Sep 17 00:00:00 2001
> From: Maxim Levitsky <maximlevitsky@gmail.com>
> Date: Mon, 26 Jul 2010 18:14:15 +0300
> Subject: [PATCH] INPUT: fix crash on setkeycode.
> 
> due to typo, the ->setkeycodebig wasn't initialized
> with default values
> 
> This is the reason behind crash I had recently.
> 
> <1>[   12.514524] BUG: unable to handle kernel NULL pointer dereference at (null)
> <1>[   12.524251] IP: [<(null)>] (null)
> <4>[   12.524251] PGD 0 
> <0>[   12.524251] Oops: 0010 [#1] PREEMPT SMP 
> <0>[   12.524251] last sysfs file: /sys/devices/pci0000:00/0000:00:1f.1/host3/uevent
> <4>[   12.524251] CPU 0 
> <4>[   12.524251] Modules linked in: cpufreq_powersave cpufreq_conservative libphy cpufreq_userspace acpi_cpufreq mperf iTCO_wdt sg r852 sm_common battery video ac iTCO_vendor_support coretemp nand nand_ids nand_ecc mtd evdev snd_page_alloc serio_raw
> <4>[   12.524251] 
> <4>[   12.524251] Pid: 1368, comm: keymap Not tainted 2.6.35-rc6+ #79 Nettiling/Aspire 5720     
> <4>[   12.524251] RIP: 0010:[<0000000000000000>]  [<(null)>] (null)
> <4>[   12.524251] RSP: 0018:ffff88006d4fbcb0  EFLAGS: 00010046
> <4>[   12.524251] RAX: 0000000000000000 RBX: ffff88006fe4f000 RCX: 00000000000000a5
> <4>[   12.524251] RDX: 00000000000000a5 RSI: ffff88006d4fbcc8 RDI: ffff88006fe4f000
> <4>[   12.524251] RBP: ffff88006d4fbd28 R08: ffff8800375b4538 R09: 0000000000000001
> <4>[   12.524251] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88006fe4f840
> <4>[   12.524251] R13: 0000000000000286 R14: 000000000000008a R15: ffff88006d4fbcc8
> <4>[   12.524251] FS:  00007fcba7947700(0000) GS:ffff880002400000(0000) knlGS:0000000000000000
> <4>[   12.858922] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[   12.858922] CR2: 0000000000000000 CR3: 000000006cc0e000 CR4: 00000000000006f0
> <4>[   12.858922] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>[   12.858922] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> <4>[   12.858922] Process keymap (pid: 1368, threadinfo ffff88006d4fa000, task ffff8800375b4500)
> <0>[   12.858922] Stack:
> <4>[   12.858922]  ffffffff812b687f 000000000000000d 000000a5025d3190 000000a50000008a
> <4>[   12.858922] <0> 0000000000000004 0000000000000000 ffff88006d4fbcc4 ffff88006d4fbd08
> <4>[   12.858922] <0> ffff8800375b4500 ffff88006d4fbd08 00000000000000a5 00007fffd1b26350
> <0>[   12.858922] Call Trace:
> <4>[   12.858922]  [<ffffffff812b687f>] ? input_set_keycode+0x16f/0x180
> <4>[   12.858922]  [<ffffffffa00109b8>] evdev_do_ioctl+0x3d8/0xa90 [evdev]
> <4>[   12.858922]  [<ffffffff81037e9d>] ? sub_preempt_count+0x9d/0xd0
> <4>[   12.858922]  [<ffffffff813a4021>] ? mutex_lock_interruptible_nested+0x2a1/0x410
> <4>[   12.858922]  [<ffffffffa00110b7>] ? evdev_ioctl_handler+0x47/0xa0 [evdev]
> <4>[   12.858922]  [<ffffffffa00110b7>] ? evdev_ioctl_handler+0x47/0xa0 [evdev]
> <4>[   12.858922]  [<ffffffffa0011109>] evdev_ioctl_handler+0x99/0xa0 [evdev]
> <4>[   12.858922]  [<ffffffffa001113b>] evdev_ioctl+0xb/0x10 [evdev]
> <4>[   12.858922]  [<ffffffff810eb9f8>] vfs_ioctl+0x38/0xd0
> <4>[   12.858922]  [<ffffffff810ebbda>] do_vfs_ioctl+0x8a/0x600
> <4>[   12.858922]  [<ffffffff810ec19a>] sys_ioctl+0x4a/0x80
> <4>[   12.858922]  [<ffffffff81002deb>] system_call_fastpath+0x16/0x1b
> <0>[   12.858922] Code:  Bad RIP value.
> 
> Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
> ---
>  drivers/input/input.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 43aeb71..ce5d90d 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -1850,7 +1850,7 @@ int input_register_device(struct input_dev *dev)
>  			dev->getkeycodebig_from_scancode = input_default_getkeycode_from_scancode;
>  	}
>  
> -	if (dev->setkeycode) {
> +	if (!dev->setkeycode) {
>  		if (!dev->setkeycodebig)
>  			dev->setkeycodebig = input_default_setkeycode;
>  	}
Please disregard this.
This bug is already fixed by:
http://git.linuxtv.org/v4l-dvb.git?a=commitdiff;h=2bec574ec14e3478b1971411dec5ab96b6159995

I was using  git://linuxtv.org/v4l-dvb.git devel/for_v2.6.36
which didn't contain that fix.


Best regards,
Maxim Levitsky

