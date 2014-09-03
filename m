From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 15:10:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409031509070.12309@pobox.suse.cz>
References: <20140902174659.GA1811@datura.dylex.net> <54062150.2010800@gmail.com> <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz> <20140903023531.GA1128@datura.dylex.net> <alpine.LNX.2.00.1409030928200.12309@pobox.suse.cz> <20140903081723.GA1153@datura.dylex.net>
 <alpine.LNX.2.00.1409031021230.12309@pobox.suse.cz> <20140903130348.GA1161@datura.dylex.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35043 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303AbaICNKl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 09:10:41 -0400
In-Reply-To: <20140903130348.GA1161@datura.dylex.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dylan Alex Simon <dylan-kernel@dylex.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Wed, 3 Sep 2014, Dylan Alex Simon wrote:

> Still no luck (it really is using the new module, even though it didn't
> rebuild the kernel).  I should also mention this is gcc 4.9.1.  I can rebuild
> with 4.8.3 if there's a reason to suspect that, though I haven't seen any
> other issues.
> 
> [  145.571979] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> [  149.151153] BUG: unable to handle kernel paging request at ffffffffa00aa0cf
> [  149.151246] IP:
> [  149.151251]  [<ffffffffa00aa0cf>] 0xffffffffa00aa0cf
> [  149.151257] PGD 1814067 PUD 1815063 PMD 42ba9e067 PTE 0
> [  149.151262] Oops: 0010 [#1] SMP 
> [  149.151273] Modules linked in: led_class cuse fuse snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer ipt_ULOG [last unloaded: hid_thingm]
> [  149.151279] CPU: 7 PID: 664 Comm: kworker/7:2 Not tainted 3.16.1-00001-g98fed6d-dirty #146
> [  149.151280] Hardware name: empty empty/S8010-LE, BIOS 'V2.03B   ' 03/15/2012
> [  149.151286] Workqueue: events 0xffffffffa00aa040
> [  149.151288] task: ffff88042de12010 ti: ffff8800bb96c000 task.ti: ffff8800bb96c000
> [  149.151294] RIP: 0010:[<ffffffffa00aa0cf>]  [<ffffffffa00aa0cf>] 0xffffffffa00aa0cf
> [  149.151296] RSP: 0018:ffff8800bb96fdd0  EFLAGS: 00010286
> [  149.151298] RAX: 0000000000000009 RBX: ffff88042ba612f0 RCX: 0000000000000302
> [  149.151300] RDX: 0000000000000049 RSI: 0000000000000286 RDI: ffff88042aa95d80
> [  149.151302] RBP: ffff8800bb96fdf0 R08: ffff8804aaa95d80 R09: 0000000000000282
> [  149.151303] R10: 000000716d515080 R11: 0000000000000026 R12: ffff88042d189940
> [  149.151305] R13: 0000000000000000 R14: ffff88043edd4e00 R15: ffff88043edd13c0
> [  149.151308] FS:  00007f383d7a3700(0000) GS:ffff88043edc0000(0000) knlGS:0000000000000000
> [  149.151311] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  149.151315] CR2: ffffffffa00aa0cf CR3: 0000000001813000 CR4: 00000000000407e0
> [  149.151316] Stack:
> [  149.151321]  010000000000a000 0001000000000063 00000000f7ea6138 ffff88042ba612f0
> [  149.151325]  ffff8800bb96fe38 ffffffff81052c2f ffff88043edd13c0 000000003edd13c0
> [  149.151329]  ffff88043edd13c0 ffff88043edd13e8 ffff88042de12010 ffff88042d189970
> [  149.151330] Call Trace:
> [  149.151341]  [<ffffffff81052c2f>] process_one_work+0x14f/0x400
> [  149.151349]  [<ffffffff81053423>] worker_thread+0x63/0x540
> [  149.151354]  [<ffffffff810533c0>] ? create_and_start_worker+0x60/0x60
> [  149.151359]  [<ffffffff81059038>] kthread+0xe8/0x100
> [  149.151364]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
> [  149.151370]  [<ffffffff815323ec>] ret_from_fork+0x7c/0xb0
> [  149.151374]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0

Hrm, what we really want is to first destroy the LED interface, otherwise 
someone might have re-queued the workqueue through thingm_led_set() after 
it has been flushed / cancelled already.

Could you please give it one more shot with the patch below? Thanks for 
your prompt testing.


diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 134be89..3d8cf5e 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -208,10 +208,10 @@ unregister_red:
 
 static void thingm_remove_rgb(struct thingm_rgb *rgb)
 {
-	flush_work(&rgb->work);
 	led_classdev_unregister(&rgb->red.ldev);
 	led_classdev_unregister(&rgb->green.ldev);
 	led_classdev_unregister(&rgb->blue.ldev);
+	cancel_work_sync(&rgb->work);
 }
 
 static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
@@ -286,10 +286,10 @@ static void thingm_remove(struct hid_device *hdev)
 	struct thingm_device *tdev = hid_get_drvdata(hdev);
 	int i;
 
+	hid_hw_stop(hdev);
+
 	for (i = 0; i < tdev->fwinfo->numrgb; ++i)
 		thingm_remove_rgb(tdev->rgb + i);
-
-	hid_hw_stop(hdev);
 }
 
 static const struct hid_device_id thingm_table[] = {

-- 
Jiri Kosina
SUSE Labs
