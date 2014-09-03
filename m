From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: Re: hid-thingm: kernel panic on remove
Date: Tue, 2 Sep 2014 22:35:32 -0400
Message-ID: <20140903023531.GA1128@datura.dylex.net>
References: <20140902174659.GA1811@datura.dylex.net>
 <54062150.2010800@gmail.com>
 <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:48792 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753196AbaICCff (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 22:35:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1409022328470.12309@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

>From Jiri Kosina <jkosina@suse.cz>, Tue, Sep 02, 2014 at 11:32:30PM +0200:
> On Tue, 2 Sep 2014, Benjamin Tissoires wrote:
> 
> > > Whenever either disconnecting the USB device or simply rmmod'ing the module
> > > (even when not in use), I get a kernel panic.  I haven't managed to capture a
> > > backtrace, but at least the first two lines were saved after an rmmod:
> > > 
> > > 18:53:17 kernel: thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
> > > <snip, rmmod hid-thingm:>
> > > 08:38:42 kernel: BUG: unable to handle kernel paging request at fffffffb8a80aaf8
> > > 08:38:42 kernel: IP: [<ffffffff8106e30c>] osq_lock+0x3c/0x110
> 
> Hmm, so the only lock that is taken in thingm driver itself is 
> rgb->tdev->lock, which is thingm_device->lock, properly initialized in 
> _probe().
> 
> So my first thought was that the work is not cancelled properly, causing 
> use-after-free on the lock with the workqueue firing at the time the 
> drvier has cleaned up everything, but that doesn't seem to be the case, as 
> thingm_remove() -> thingm_remove_rgb() seems to be doing the right thing.
> 
> Dylan, is there any chance for you to capture more complete backtrace from 
> the oops? serial console, netconsole, anything?

Some combination of kernel debugging options and killing processes let it
survive long enough to write the backtrace to disk.  A simple modprobe/rmmod
wasn't enough, though, it required a few tries removing the device and then
rmmod (though has definitely happend on just one removal before).  Let me know
if there's anything else I can try.

<insmod>
[   28.855960] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
<rmmod;insmod>
[  147.037008] thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
<unplug>
[  218.496688] usb 1-3.1.4: USB disconnect, device number 7
[  218.502278] hid : failed to write color
[  218.506131] hid : failed to write color
<plug>
[  233.557300] usb 1-3.1.4: new full-speed USB device number 8 using ehci-pci
[  233.657195] usb 1-3.1.4: config 1 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 1
[  233.660402] thingm 0003:27B8:01ED.0005: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
<rmmod>
[  253.682724] BUG: unable to handle kernel paging request at ffffffffa00af0cf
[  253.682807] IP:
[  253.682812]  [<ffffffffa00af0cf>] 0xffffffffa00af0cf
[  253.682817] PGD 1814067 PUD 1815063 PMD 42cace067 PTE 0
[  253.682820] Oops: 0010 [#1] SMP 
[  253.682830] Modules linked in: led_class cuse fuse snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer ipt_ULOG [last unloaded: hid_thingm]
[  253.682833] CPU: 0 PID: 849 Comm: kworker/0:2 Not tainted 3.16.1-00001-g98fed6d #145
[  253.682835] Hardware name: empty empty/S8010-LE, BIOS 'V2.03B   ' 03/15/2012
[  253.682838] Workqueue: events 0xffffffffa00af040
[  253.682840] task: ffff88042e330050 ti: ffff880429d8c000 task.ti: ffff880429d8c000
[  253.682844] RIP: 0010:[<ffffffffa00af0cf>]  [<ffffffffa00af0cf>] 0xffffffffa00af0cf
[  253.682846] RSP: 0018:ffff880429d8fdd0  EFLAGS: 00010286
[  253.682847] RAX: 0000000000000009 RBX: ffff88042ca83af0 RCX: 0000000000000302
[  253.682849] RDX: 0000000000000078 RSI: 0000000000000286 RDI: ffff88042caaade0
[  253.682850] RBP: ffff880429d8fdf0 R08: ffff8804acaaade0 R09: 0000000000000282
[  253.682852] R10: ffff88042c93dbc0 R11: 000000000000001f R12: ffff88042c885e80
[  253.682853] R13: 0000000000000000 R14: ffff88043ec14e00 R15: ffff88043ec113c0
[  253.682856] FS:  00007f58ebcec700(0000) GS:ffff88043ec00000(0000) knlGS:0000000000000000
[  253.682857] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  253.682859] CR2: ffffffffa00af0cf CR3: 0000000001813000 CR4: 00000000000407f0
[  253.682859] Stack:
[  253.682863]  010000000000a000 0001000000000063 000000008867f918 ffff88042ca83af0
[  253.682866]  ffff880429d8fe38 ffffffff81052c2f ffff88043ec113c0 000000003ec113c0
[  253.682869]  ffff88043ec113c0 ffff88043ec113e8 ffff88042e330050 ffff88042c885eb0
[  253.682870] Call Trace:
[  253.682878]  [<ffffffff81052c2f>] process_one_work+0x14f/0x400
[  253.682882]  [<ffffffff81053423>] worker_thread+0x63/0x540
[  253.682886]  [<ffffffff810533c0>] ? create_and_start_worker+0x60/0x60
[  253.682889]  [<ffffffff81059038>] kthread+0xe8/0x100
[  253.682893]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  253.682897]  [<ffffffff815323ec>] ret_from_fork+0x7c/0xb0
[  253.682900]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  253.682906] Code:  Bad RIP value.
[  253.682908] RIP  [<ffffffffa00af0cf>] 0xffffffffa00af0cf
[  253.682909]  RSP <ffff880429d8fdd0>
[  253.682910] CR2: ffffffffa00af0cf
[  253.682913] ---[ end trace 38f1b789201cd967 ]---
[  253.682946] BUG: unable to handle kernel paging request at ffffffffffffffc8
[  253.682950] IP: [<ffffffff810595eb>] kthread_data+0xb/0x20
[  253.682953] PGD 1814067 PUD 1816067 PMD 0 
[  253.682955] Oops: 0000 [#2] SMP 
[  253.682964] Modules linked in: led_class cuse fuse snd_emu10k1 snd_hwdep snd_util_mem snd_ac97_codec ac97_bus snd_rawmidi snd_seq_device snd_pcm snd_timer ipt_ULOG [last unloaded: hid_thingm]
[  253.682967] CPU: 0 PID: 849 Comm: kworker/0:2 Tainted: G      D       3.16.1-00001-g98fed6d #145
[  253.682969] Hardware name: empty empty/S8010-LE, BIOS 'V2.03B   ' 03/15/2012
[  253.682987] task: ffff88042e330050 ti: ffff880429d8c000 task.ti: ffff880429d8c000
[  253.682990] RIP: 0010:[<ffffffff810595eb>]  [<ffffffff810595eb>] kthread_data+0xb/0x20
[  253.682992] RSP: 0018:ffff880429d8fa40  EFLAGS: 00010002
[  253.682993] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffff80cd76
[  253.682995] RDX: 0000000050f1eeb6 RSI: 0000000000000000 RDI: ffff88042e330050
[  253.682996] RBP: ffff880429d8fa40 R08: ffff88042c8928a0 R09: 0000000000000001
[  253.682998] R10: 00000000000001ea R11: 0000000000000000 R12: 0000000000000000
[  253.682999] R13: ffff88042e330400 R14: 0000000000000000 R15: ffff88042e330050
[  253.683002] FS:  00007f58ebcec700(0000) GS:ffff88043ec00000(0000) knlGS:0000000000000000
[  253.683003] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  253.683005] CR2: 0000000000000028 CR3: 0000000001813000 CR4: 00000000000407f0
[  253.683005] Stack:
[  253.683009]  ffff880429d8fa58 ffffffff8105396c ffff88043ec11c40 ffff880429d8fac0
[  253.683011]  ffffffff8152db81 000000000000a000 ffff88042e330050 ffff880429d8fa88
[  253.683014]  ffff880429d8ffd8 ffff880429d8fad0 ffffffff8103e2a9 ffff88042e330610
[  253.683015] Call Trace:
[  253.683019]  [<ffffffff8105396c>] wq_worker_sleeping+0xc/0x90
[  253.683024]  [<ffffffff8152db81>] __schedule+0x4b1/0x730
[  253.683029]  [<ffffffff8103e2a9>] ? release_task+0x249/0x3d0
[  253.683033]  [<ffffffff8152de24>] schedule+0x24/0x60
[  253.683036]  [<ffffffff8103eb92>] do_exit+0x762/0xa10
[  253.683041]  [<ffffffff81005998>] oops_end+0x68/0x90
[  253.683046]  [<ffffffff8103242c>] no_context+0x12c/0x2f0
[  253.683050]  [<ffffffff81032675>] __bad_area_nosemaphore+0x85/0x1f0
[  253.683054]  [<ffffffff810327ee>] bad_area_nosemaphore+0xe/0x10
[  253.683058]  [<ffffffff81032b16>] __do_page_fault+0xb6/0x4d0
[  253.683062]  [<ffffffff81531e09>] ? _raw_spin_unlock_irq+0x9/0x10
[  253.683066]  [<ffffffff8141a43f>] ? urb_destroy+0x1f/0x30
[  253.683069]  [<ffffffff8141ad09>] ? usb_free_urb+0x19/0x20
[  253.683072]  [<ffffffff8141b342>] ? usb_start_wait_urb+0xa2/0xf0
[  253.683075]  [<ffffffff81032f5c>] do_page_fault+0xc/0x10
[  253.683079]  [<ffffffff81533922>] page_fault+0x22/0x30
[  253.683084]  [<ffffffff81052c2f>] process_one_work+0x14f/0x400
[  253.683087]  [<ffffffff81053423>] worker_thread+0x63/0x540
[  253.683091]  [<ffffffff810533c0>] ? create_and_start_worker+0x60/0x60
[  253.683093]  [<ffffffff81059038>] kthread+0xe8/0x100
[  253.683097]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  253.683100]  [<ffffffff815323ec>] ret_from_fork+0x7c/0xb0
[  253.683103]  [<ffffffff81058f50>] ? kthread_create_on_node+0x1b0/0x1b0
[  253.683132] Code: 00 48 89 e5 5d 48 8b 40 b8 48 c1 e8 02 83 e0 01 c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 48 8b 87 58 03 00 00 55 48 89 e5 <48> 8b 40 c8 5d c3 66 66 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 
[  253.683135] RIP  [<ffffffff810595eb>] kthread_data+0xb/0x20
[  253.683136]  RSP <ffff880429d8fa40>
[  253.683137] CR2: ffffffffffffffc8
[  253.683139] ---[ end trace 38f1b789201cd968 ]---
[  253.683140] Fixing recursive fault but reboot is needed!
[  313.753106] INFO: rcu_sched detected stalls on CPUs/tasks: { 0} (detected by 7, t=18003 jiffies, g=1479, c=1478, q=300)
<more traces follow but probably irrelevant>
