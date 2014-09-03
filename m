From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 04:17:23 -0400
Message-ID: <20140903081723.GA1153@datura.dylex.net>
References: <20140902174659.GA1811@datura.dylex.net>
 <54062150.2010800@gmail.com>
 <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
 <20140903023531.GA1128@datura.dylex.net>
 <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:33396 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbaICIR1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 04:17:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

>From Jiri Kosina <jkosina@suse.cz>, Wed, Sep 03, 2014 at 09:29:07AM +0200:
> On Tue, 2 Sep 2014, Dylan Alex Simon wrote:
> 
> > Some combination of kernel debugging options and killing processes let it
> > survive long enough to write the backtrace to disk.  A simple modprobe/rmmod
> > wasn't enough, though, it required a few tries removing the device and then
> > rmmod (though has definitely happend on just one removal before).  Let me know
> > if there's anything else I can try.
> 
> Alright, this supports my original hunch. I think I see the race. Could 
> you please try the patch below? Thanks.
> 
> 
> 
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 134be89..743a517 100644
> --- a/drivers/hid/hid-thingm.c
> +++ b/drivers/hid/hid-thingm.c
> @@ -208,7 +208,7 @@ unregister_red:
>  
>  static void thingm_remove_rgb(struct thingm_rgb *rgb)
>  {
> -	flush_work(&rgb->work);
> +	cancel_work_sync(&rgb->work);
>  	led_classdev_unregister(&rgb->red.ldev);
>  	led_classdev_unregister(&rgb->green.ldev);
>  	led_classdev_unregister(&rgb->blue.ldev);

Same problem (only rmmod this time, no write error, but still
doesn't happen every time):

[  213.180726] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
<rmmod>
[  217.399934] BUG: unable to handle kernel paging request at ffffffffa00aa0cf
[  217.400034] IP:
[  217.400038]  [<ffffffffa00aa0cf>] 0xffffffffa00aa0cf
[  217.400039] PGD 1814067 
[  217.400040] PUD 1815063 
[  217.400044] PMD 42c266067 PTE 0
[  217.400048] Oops: 0010 [#1] SMP 
[  217.400057] Modules linked in: led_class cuse fuse snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer ipt_ULOG [last unloaded: hid_thingm]
[  217.400061] CPU: 1 PID: 749 Comm: kworker/1:2 Not tainted 3.16.1-00001-g98fed6d-dirty #146
[  217.400063] Hardware name: empty empty/S8010-LE, BIOS 'V2.03B   ' 03/15/2012
[  217.400066] Workqueue: events 0xffffffffa00aa040
[  217.400068] task: ffff88042df88790 ti: ffff8800bb9e4000 task.ti: ffff8800bb9e4000
[  217.400072] RIP: 0010:[<ffffffffa00aa0cf>]  [<ffffffffa00aa0cf>] 0xffffffffa00aa0cf
[  217.400073] RSP: 0018:ffff8800bb9e7dd0  EFLAGS: 00010286
[  217.400075] RAX: 0000000000000009 RBX: ffff88042c285af0 RCX: 0000000000000302
[  217.400077] RDX: 0000000000000078 RSI: 0000000000000286 RDI: ffff88042d0e1a80
[  217.400078] RBP: ffff8800bb9e7df0 R08: ffff8804ad0e1a80 R09: 0000000000000282
[  217.400079] R10: 0000000000000001 R11: 000000002c95c8ba R12: ffff88042c8b0580
[  217.400081] R13: 0000000000000000 R14: ffff88043ec54e00 R15: ffff88043ec513c0
[  217.400087] FS:  00007f02217fc700(0000) GS:ffff88043ec40000(0000) knlGS:0000000000000000
[  217.400089] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  217.400091] CR2: ffffffffa00aa0cf CR3: 000000042af90000 CR4: 00000000000407e0
[  217.400091] Stack:
[  217.400096]  010000000000a000 0001000000000063 000000000ba997f6 ffff88042c285af0
[  217.400099]  ffff8800bb9e7e38 ffffffff81052c2f ffff88043ec513c0 000000003ec513c0
[  217.400104]  ffff88043ec513c0 ffff88043ec513e8 ffff88042df88790 ffff88042c8b05b0
[  217.400105] Call Trace:
[  217.400114]  [<ffffffff81052c2f>] process_one_work+0x14f/0x400
[  217.400120]  [<ffffffff81053423>] worker_thread+0x63/0x540
[  217.400125]  [<ffffffff810533c0>] ? create_and_start_worker+0x60/0x60
[  217.400130]  [<ffffffff81059038>] kthread+0xe8/0x100
[  217.400136]  [<ffffffff8152de24>] ? schedule+0x24/0x60
[  217.400144]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  217.400149]  [<ffffffff815323ec>] ret_from_fork+0x7c/0xb0
[  217.400153]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  217.400159] Code:  Bad RIP value.
[  217.400163] RIP  [<ffffffffa00aa0cf>] 0xffffffffa00aa0cf
[  217.400164]  RSP <ffff8800bb9e7dd0>
[  217.400165] CR2: ffffffffa00aa0cf
[  217.400168] ---[ end trace 9bd9c9db3e942a93 ]---
