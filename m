From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 09:29:07 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz>
References: <20140902174659.GA1811@datura.dylex.net> <54062150.2010800@gmail.com> <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz> <20140903023531.GA1128@datura.dylex.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56171 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbaICH3K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 03:29:10 -0400
In-Reply-To: <20140903023531.GA1128@datura.dylex.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dylan Alex Simon <dylan-kernel@dylex.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Tue, 2 Sep 2014, Dylan Alex Simon wrote:

> Some combination of kernel debugging options and killing processes let it
> survive long enough to write the backtrace to disk.  A simple modprobe/rmmod
> wasn't enough, though, it required a few tries removing the device and then
> rmmod (though has definitely happend on just one removal before).  Let me know
> if there's anything else I can try.
> 
> <insmod>
> [   28.855960] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> <rmmod;insmod>
> [  147.037008] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> <unplug>
> [  218.496688] usb 1-3.1.4: USB disconnect, device number 7
> [  218.502278] hid : failed to write color
> [  218.506131] hid : failed to write color
> <plug>
> [  233.557300] usb 1-3.1.4: new full-speed USB device number 8 using ehci-pci
> [  233.657195] usb 1-3.1.4: config 1 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 1
> [  233.660402] thingm 0003:27B8:01ED.0005: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> <rmmod>
> [  253.682724] BUG: unable to handle kernel paging request at ffffffffa00af0cf
> [  253.682807] IP:
> [  253.682812]  [<ffffffffa00af0cf>] 0xffffffffa00af0cf
> [  253.682817] PGD 1814067 PUD 1815063 PMD 42cace067 PTE 0
> [  253.682820] Oops: 0010 [#1] SMP 
> [  253.682830] Modules linked in: led_class cuse fuse snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer ipt_ULOG [last unloaded: hid_thingm]
> [  253.682833] CPU: 0 PID: 849 Comm: kworker/0:2 Not tainted 3.16.1-00001-g98fed6d #145
> [  253.682835] Hardware name: empty empty/S8010-LE, BIOS 'V2.03B   ' 03/15/2012
> [  253.682838] Workqueue: events 0xffffffffa00af040
> [  253.682840] task: ffff88042e330050 ti: ffff880429d8c000 task.ti: ffff880429d8c000
> [  253.682844] RIP: 0010:[<ffffffffa00af0cf>]  [<ffffffffa00af0cf>] 0xffffffffa00af0cf
> [  253.682846] RSP: 0018:ffff880429d8fdd0  EFLAGS: 00010286
> [  253.682847] RAX: 0000000000000009 RBX: ffff88042ca83af0 RCX: 0000000000000302
> [  253.682849] RDX: 0000000000000078 RSI: 0000000000000286 RDI: ffff88042caaade0
> [  253.682850] RBP: ffff880429d8fdf0 R08: ffff8804acaaade0 R09: 0000000000000282
> [  253.682852] R10: ffff88042c93dbc0 R11: 000000000000001f R12: ffff88042c885e80
> [  253.682853] R13: 0000000000000000 R14: ffff88043ec14e00 R15: ffff88043ec113c0
> [  253.682856] FS:  00007f58ebcec700(0000) GS:ffff88043ec00000(0000) knlGS:0000000000000000
> [  253.682857] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  253.682859] CR2: ffffffffa00af0cf CR3: 0000000001813000 CR4: 00000000000407f0
> [  253.682859] Stack:
> [  253.682863]  010000000000a000 0001000000000063 000000008867f918 ffff88042ca83af0
> [  253.682866]  ffff880429d8fe38 ffffffff81052c2f ffff88043ec113c0 000000003ec113c0
> [  253.682869]  ffff88043ec113c0 ffff88043ec113e8 ffff88042e330050 ffff88042c885eb0
> [  253.682870] Call Trace:
> [  253.682878]  [<ffffffff81052c2f>] process_one_work+0x14f/0x400
> [  253.682882]  [<ffffffff81053423>] worker_thread+0x63/0x540
> [  253.682886]  [<ffffffff810533c0>] ? create_and_start_worker+0x60/0x60
> [  253.682889]  [<ffffffff81059038>] kthread+0xe8/0x100
> [  253.682893]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
> [  253.682897]  [<ffffffff815323ec>] ret_from_fork+0x7c/0xb0
> [  253.682900]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0

Alright, this supports my original hunch. I think I see the race. Could 
you please try the patch below? Thanks.




diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 134be89..743a517 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -208,7 +208,7 @@ unregister_red:
 
 static void thingm_remove_rgb(struct thingm_rgb *rgb)
 {
-	flush_work(&rgb->work);
+	cancel_work_sync(&rgb->work);
 	led_classdev_unregister(&rgb->red.ldev);
 	led_classdev_unregister(&rgb->green.ldev);
 	led_classdev_unregister(&rgb->blue.ldev);

-- 
Jiri Kosina
SUSE Labs
