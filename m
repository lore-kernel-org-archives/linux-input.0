From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Sleeping inside spinlock in force feedback input event code
Date: Sun, 15 Jun 2008 22:01:55 +0300
Message-ID: <48556723.2090204@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com>	 <485540A6.1050306@gmail.com>	 <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com>	 <4855507E.4030201@gmail.com>	 <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com>	 <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:45727 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750832AbYFOTB7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jun 2008 15:01:59 -0400
In-Reply-To: <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: James Carthew <jcarthew@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi all!

It seems a new spinlock input_dev->event_lock has been added [1] to the
input subsystem since the force feedback support was reworked.

However, the force feedback subsystem sleeps on events in multiple
places, e.g. ff-core.c uses a mutex, and hid-pidff driver waits for hid
io (otherwise commands were lost, IIRC; if necessary I'll test again).

ff_device->mutex is used to shield effects[], so it is locked when
handling EV_FF events, on flushes, and on effect upload and erase ioctls.

Maybe we should make EV_FF handling atomic? For effect uploading we
could either make it completely atomic, or lock only for reserving the
effect slot, then release the lock, and mark it as ready after upload is
complete.
Making even the upload completely atomic would mean that no force
feedback events/ioctl() would sleep, which AFAIK would be a plus for
userspace ff applications. On the other hand, hid-pidff (device managed
mode) driver doesn't know whether effect upload was successful until it
has received a report from the device, so it wouldn't be able to report
failure immediately. Other drivers would, though.

What do you think?

I just noticed this (due to James' freeze report below), so I haven't
yet put much thought into this.

[1]
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=8006479c9b75fb6594a7b746af3d7f1fbb68f18f

James Carthew wrote:
> ok I managed to get sysrq to print some stuff out by switching to
> console logging level 6:
> BUG: scheduling while atomic: ffcfstress/6888/0x00000003
> PID: 6888, comm: ffcfstress Tainted: P 2.6.26-rc5 #2
> [<c0757a2f>] schedule+0x9b/0x5f9
> [<c0226ccf>] lock_timer_base+0x19/0x35
> [<c0759431>] _spin_unlock_irqrestore+0xe/0x21]
> [<c0226de0>] __mod_timer+0x97/0xa1
> [<c075813f>] schedule_timeout+0x6b/0x86
> [<c0226bb5>] process_timeout+0x0/0x5
> [<c069ad55>] usbhid_wait_io+0x76/0xb9
> [<c022eebd>] autoremove_wake_function+0x0/0x2b
> [<c069c8c1>] pidff_playback_pid+0x3c/0x49
> [<c069c9ac>] pidff_playback+0x15/0x18
> [<c0665dd6>] input_ff_event+0x79/0x89
> [<c0665d5d>] input_ff_event+0x0/0x89
> [<c0664d5d>] input_handle_event+0x32a/0x362
> [<c0665728>] input_inject_event+0x59/0x92
> [<c0668bff>] evdev_write+0x77/0x84
> [<c0668b88>] evdev_write+0x0/0x84
> [<c025ed95>] vfs_write+0x83/0xf6
> [<c025f2a2>] sys_write+0x3c/0x63
> [<c02038dd>] sysenter_past_esp+0x6a/0x91


-- 
Anssi Hannula
