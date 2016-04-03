From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: uinput: ioctls for UI_BEGIN_FF_UPLOAD fails (returns -1). How to
 debug?
Date: Sun, 3 Apr 2016 12:02:53 +0200
Message-ID: <5700EA4D.20700@m-reimer.de>
References: <56F82C42.6020002@m-reimer.de>
 <CAM4jgCp_t_mvayUbBnz_1aznbvZJz8jFLxbD49r=qLZCdOhH7Q@mail.gmail.com>
 <56F8F107.3050906@m-reimer.de>
 <CAM4jgCo9a-6ati0tQWCZqBRyxM6E6NrQK6Cj0uGQAogCRMgrOA@mail.gmail.com>
 <56FAB1D3.5020003@m-reimer.de> <56FD628A.6040606@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:57010 "EHLO mx2.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbcDCKC6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Apr 2016 06:02:58 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx2.mailbox.org (Postfix) with ESMTPS id BC4D8434B9
	for <linux-input@vger.kernel.org>; Sun,  3 Apr 2016 12:02:55 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id IGqioiHu5AcW for <linux-input@vger.kernel.org>;
	Sun,  3 Apr 2016 12:02:54 +0200 (CEST)
In-Reply-To: <56FD628A.6040606@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On 03/31/2016 07:46 PM, Manuel Reimer wrote:
> On 03/29/2016 06:48 PM, Manuel Reimer wrote:
>> As the idea was to publish this under GPL3 anyway, I've uploaded my
>> early development state:
>>
>> https://github.com/M-Reimer/pspaddrv
>
> I'm still getting the errors and I'm still not finding any reason for them.

Sorry for the spam, but my hope is that someone may have some hint that 
helps me to track this down.

To further narrow things down, I commented the following line:
https://github.com/M-Reimer/pspaddrv/blob/master/device-handler.c#L176

This means, that my code does no longer actually do any sending to uinput!

And.... I still have the same problem... :(

So in other words: As soon as the attached gamepad starts to send data 
to my daemon, the uinput interaction on the same daemon somehow gets 
influenced/completely blocked.

So the only explanation, I have for this, is that something wents really 
wrong somewhere deeper in the kernel. Maybe something with libusb/uinput 
in combination?

If the problem occurs, the system (I use a VM to not harm my main 
system) doesn't shut down properly.

In dmesg, I found the following:



[   30.782513] input: Microsoft X-Box 360 pad as 
/devices/virtual/input/input9
[  240.130071] INFO: task fftest:379 blocked for more than 120 seconds.
[  240.381802]       Tainted: G           O    4.4.5-1-ARCH #1
[  240.391841] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  240.392592] fftest          D ffff88003cda3ba8     0   379    371 
0x00000000
[  240.392596]  ffff88003cda3ba8 ffff880037b84800 ffffffff81810500 
ffff88003ce16040
[  240.392598]  ffff88003cda4000 ffff88003cda3d58 ffff88003cda3d50 
0000000000000000
[  240.392600]  ffff88003ce16040 ffff88003cda3bc0 ffffffff815935ec 
7fffffffffffffff
[  240.392601] Call Trace:
[  240.392608]  [<ffffffff815935ec>] schedule+0x3c/0x90
[  240.392611]  [<ffffffff81596086>] schedule_timeout+0x1d6/0x260
[  240.392613]  [<ffffffff81592e7a>] ? __schedule+0x3aa/0xae0
[  240.392615]  [<ffffffff815941a2>] wait_for_common+0xc2/0x180
[  240.392617]  [<ffffffff810a0ae0>] ? wake_up_q+0x70/0x70
[  240.392619]  [<ffffffff8159427d>] wait_for_completion+0x1d/0x20
[  240.392624]  [<ffffffffa039f728>] 
uinput_request_submit.part.0+0x98/0xb0 [uinput]
[  240.392626]  [<ffffffffa03a0595>] uinput_dev_upload_effect+0x55/0x80 
[uinput]
[  240.392629]  [<ffffffff8142f4c1>] input_ff_upload+0x181/0x300
[  240.392632]  [<ffffffffa0324d6b>] evdev_ioctl_handler+0xa8b/0x1150 
[evdev]
[  240.392634]  [<ffffffff813a0810>] ? n_tty_open+0xe0/0xe0
[  240.392636]  [<ffffffffa0325460>] evdev_ioctl+0x10/0x12 [evdev]
[  240.392643]  [<ffffffff811f3258>] do_vfs_ioctl+0x298/0x480
[  240.392646]  [<ffffffff811e1662>] ? vfs_write+0x152/0x1a0
[  240.392648]  [<ffffffff811f34b9>] SyS_ioctl+0x79/0x90
[  240.392649]  [<ffffffff815970ee>] entry_SYSCALL_64_fastpath+0x12/0x6d
[  360.390898] INFO: task fftest:379 blocked for more than 120 seconds.
[  360.406008]       Tainted: G           O    4.4.5-1-ARCH #1
[  360.406629] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  360.407664] fftest          D ffff88003cda3ba8     0   379    371 
0x00000000
[  360.407668]  ffff88003cda3ba8 ffff880037b84800 ffffffff81810500 
ffff88003ce16040
[  360.407670]  ffff88003cda4000 ffff88003cda3d58 ffff88003cda3d50 
0000000000000000
[  360.407671]  ffff88003ce16040 ffff88003cda3bc0 ffffffff815935ec 
7fffffffffffffff
[  360.407673] Call Trace:
[  360.407692]  [<ffffffff815935ec>] schedule+0x3c/0x90
[  360.407694]  [<ffffffff81596086>] schedule_timeout+0x1d6/0x260
[  360.407696]  [<ffffffff81592e7a>] ? __schedule+0x3aa/0xae0
[  360.407698]  [<ffffffff815941a2>] wait_for_common+0xc2/0x180
[  360.407701]  [<ffffffff810a0ae0>] ? wake_up_q+0x70/0x70
[  360.407702]  [<ffffffff8159427d>] wait_for_completion+0x1d/0x20
[  360.407707]  [<ffffffffa039f728>] 
uinput_request_submit.part.0+0x98/0xb0 [uinput]
[  360.407708]  [<ffffffffa03a0595>] uinput_dev_upload_effect+0x55/0x80 
[uinput]
[  360.407711]  [<ffffffff8142f4c1>] input_ff_upload+0x181/0x300
[  360.407715]  [<ffffffffa0324d6b>] evdev_ioctl_handler+0xa8b/0x1150 
[evdev]
[  360.407717]  [<ffffffff813a0810>] ? n_tty_open+0xe0/0xe0
[  360.407719]  [<ffffffffa0325460>] evdev_ioctl+0x10/0x12 [evdev]
[  360.407721]  [<ffffffff811f3258>] do_vfs_ioctl+0x298/0x480
[  360.407724]  [<ffffffff811e1662>] ? vfs_write+0x152/0x1a0
[  360.407725]  [<ffffffff811f34b9>] SyS_ioctl+0x79/0x90
[  360.407727]  [<ffffffff815970ee>] entry_SYSCALL_64_fastpath+0x12/0x6d


Maybe someone can help to find the reason... To be honest, I start to 
give up to get a proper input driver done with Linux... :( Every 
attempt, so far, ended in the kernel hanging somehow...

Thank you very much in advance for any help.

Manuel
