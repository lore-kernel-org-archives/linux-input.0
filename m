From: <samu.p.onkalo@nokia.com>
Subject: RE: [PATCH] input: polldev can cause crash in case of polling
 disabled
Date: Wed, 17 Feb 2010 09:56:33 +0100
Message-ID: <62697B07E9803846BC582181BD6FB6B82661D4AAC2@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1266331481-2094-1-git-send-email-samu.p.onkalo@nokia.com>
 <20100216175047.GB15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4A81B@NOK-EUMSG-02.mgdnok.nokia.com>
 <20100216214309.GC15376@core.coreip.homeip.net>
 <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53960 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934175Ab0BQI5U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Feb 2010 03:57:20 -0500
In-Reply-To: <62697B07E9803846BC582181BD6FB6B82661D4AA59@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, oleg@redhat.com
Cc: linux-input@vger.kernel.org



>-----Original Message-----
>From: linux-input-owner@vger.kernel.org [mailto:linux-input-
>owner@vger.kernel.org] On Behalf Of Onkalo Samu.P (Nokia-D/Tampere)
>Sent: 17 February, 2010 10:16
>To: dmitry.torokhov@gmail.com; oleg@redhat.com
>Cc: linux-input@vger.kernel.org
>Subject: RE: [PATCH] input: polldev can cause crash in case of polling
>disabled
>
>
>
>>-----Original Message-----
>>From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>>Sent: 16 February, 2010 23:43
>>To: Onkalo Samu.P (Nokia-D/Tampere); oleg@redhat.com
>>Cc: linux-input@vger.kernel.org
>>Subject: Re: [PATCH] input: polldev can cause crash in case of polling
>>disabled
>>
>>On Tue, Feb 16, 2010 at 07:37:49PM +0100, samu.p.onkalo@nokia.com
>wrote:
>>>
>>>
>>> >-----Original Message-----
>>> >From: ext Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
>>> >Sent: 16 February, 2010 19:51
>>> >To: Onkalo Samu.P (Nokia-D/Tampere)
>>> >Cc: linux-input@vger.kernel.org
>>> >Subject: Re: [PATCH] input: polldev can cause crash in case of
>>polling
>>> >disabled
>>> >
>>> >Hi Samu,
>>> >
>>> >On Tue, Feb 16, 2010 at 04:44:41PM +0200, Samu Onkalo wrote:
>>> >> If polling is set to disabled value and polled input device
>>> >> is opened and closed several times, address to workqueue will
>>probably
>>> >> change at some point. Since nothing is queued (due to polled
>>disabled
>>> >> state), content of the work struct contains pointer to the old and
>>> >non-existent
>>> >> workqueue.
>>> >
>>> >This I do not quite understand. The work struct as far as I can see
>>does
>>> >not reference workqueue at all. There is a list entry but if we do
>>not
>>> >poll the device that entry should be always detached from any lists.
>>We
>>> >properly initialize WQ entry when we create the device and it shoudl
>>> >remain valid until the device is destroyed.
>>>
>>> 'data' entry contains a pointer to per-cpu-workqueue which in turn
>>contains
>>> the workqueue pointer. This 'data' entry is not ok in case of
>failure.
>>I can
>>> Collect more data about this.
>>>
>>> >
>>> >> When the device is closed again, cancel_delayed_work_sync
>>> >> goes crazy due to pointer to nonexisting workqueue.
>>> >>
>>> >
>>> >What kind of failure do you see? Is there a stack trace or
>something?
>>>
>>> Kernel panic while in workqueue handling (paging fault with some
>>crappy address).
>
>It looks like this (in ARM):
>[   88.974884] Unable to handle kernel paging request at virtual address
>732e726f
>[   88.994445] pgd = c0004000
>[   88.997192] [732e726f] *pgd=00000000
>[   89.013610] Internal error: Oops: 5 [#1] PREEMPT
>[   89.079406] CPU: 0    Not tainted  (2.6.32-09063-g2953cf4 #30)
>[   89.085296] PC is at __cancel_work_timer+0xfc/0x1a0
>[   89.090179] LR is at __cancel_work_timer+0xec/0x1a0
>[   89.095092] pc : [<c006f880>]    lr : [<c006f870>]    psr: a0000153
>[   89.095092] sp : cf411c98  ip : cf410000  fp : cf411d1c
>[   89.106628] r10: dfba59fc  r9 : dfba59f0  r8 : dfba59e4
>[   89.111877] r7 : 00000000  r6 : 00000000  r5 : dfba59e0  r4 :
>dfba59c0
>[   89.118438] r3 : 732e726f  r2 : d34a1b00  r1 : 00000001  r0 :
>dfba59f0
>[   89.125000] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM
>Segment user
>[   89.132263] Control: 10c5387d  Table: 91110019  DAC: 00000015
>[   89.144866] Stack: (0xcf411c98 to 0xcf412000)
>[   89.149261] 1c80:
>00000002 00000000
>[   89.157470] 1ca0: c006f824 cf410000 00000000 d34a1b00 dfa3f540
>ded44078 cf411cfc cf411cc8
>[   89.165710] 1cc0: c00861d8 c0084a20 00000002 00000000 00000000
>c02b2428 cf410000 20000153
>[   89.173919] 1ce0: cf411cfc c00813a4 cf410000 20000153 cf411d44
>dfba59c0 dfb618cc dfb2b864
>[   89.182159] 1d00: df67e960 ded44078 dfa3f540 ded44078 cf411d2c
>cf411d20 c006f938 c006f790
>[   89.190368] 1d20: cf411d44 cf411d30 bf10c2fc c006f930 dfb2b0c0
>dfb618cc cf411d64 cf411d48
>[   89.198608] 1d40: c02b2458 bf10c2e8 dfb618c0 d1ca1080 dfb6193c
>df67e960 cf411d84 cf411d68
>[   89.206817] 1d60: c02b4ab8 c02b240c 00000000 cf408200 00000010
>df67e960 cf411dc4 cf411d88
>[   89.215057] 1d80: c00ce2e0 c02b4a38 00000000 00000000 cf408200
>df67e960 cf411db4 cf408200
>[   89.223266] 1da0: 00000000 d3bca000 0000000c d3bca008 00000001
>00000000 cf411dd4 cf411dc8
>[   89.231506] 1dc0: c00ce438 c00ce1bc cf411df4 cf411dd8 c00caa74
>c00ce414 00000041 00000000
>[   89.239715] 1de0: d3bca000 0000000c cf411e1c cf411df8 c005f8dc
>c00caa08 d34a1de0 d34a1b00
>[   89.247955] 1e00: d3bca000 00000002 cf411ee0 d349b684 cf411e3c
>cf411e20 c005f984 c005f85c
>[   89.256164] 1e20: 00000002 d34a1b00 cf410000 00000002 cf411e54
>cf411e40 c0060fa8 c005f950
>[   89.264404] 1e40: cf411e5c cf411e50 cf411e74 cf411e58 c00614ec
>c0060de8 c002e204 00000009
>[   89.272613] 1e60: be95167c cf410000 cf411ec4 cf411e78 c006c218
>c0061460 00000400 dfb618f0
>[   89.280853] 1e80: dfb618f0 20000153 cf411ea4 cf411fb0 d349b184
>d34d1680 cf411ebc c002e204
>[   89.289062] 1ea0: cf411fb0 be95167c 00000003 c002e204 cf410000
>00000003 cf411fac cf411ec8
>[   89.297302] 1ec0: c0030430 c006be94 d1ca1080 cf410000 cf411f3c
>00000001 c02b55a8 c0073430
>[   89.305511] 1ee0: 00000009 00000000 00000000 00000000 00000000
>c00732ec cf411ef8 cf411ef8
>[   89.313751] 1f00: c00ccbfc c01e16e0 00000000 dfae9a10 d353cdd4
>cf408200 be951644 cf411f70
>[   89.321960] 1f20: 00000400 00000400 cf410000 00000003 cf411f6c
>cf411f40 c00cd770 c02b54c4
>[   89.330200] 1f40: 00000000 00000000 cf410000 00000000 00000000
>cf408200 00000400 be951644
>[   89.338409] 1f60: cf411fa4 cf411f70 c00cd8e0 c00cd6c4 cf411f8c
>cf411f80 c0082b24 c0082250
>[   89.346649] 1f80: 00000000 00012d98 00012818 be95167c 00000003
>c002e204 cf410000 00000003
>[   89.354858] 1fa0: 00000000 cf411fb0 c002e098 c00303c0 fffffe00
>be951644 00000400 00000001
>[   89.363098] 1fc0: 00012d98 00012818 be95167c 00000003 be951644
>00000003 00000003 be951cd4
>[   89.371307] 1fe0: 00000002 be950a70 0000cfe4 400fbfcc 60000050
>00000003 00000000 00000000
>[   89.379547] Backtrace:
>[   89.382019] [<c006f784>] (__cancel_work_timer+0x0/0x1a0) from
>[<c006f938>] (cancel_delayed_work_sync+0x14/0x18)
>[   89.392181] [<c006f924>] (cancel_delayed_work_sync+0x0/0x18) from
>[<bf10c2fc>] (input_close_polled_device+0x20/0x74 [input_p)
>[   89.404174] [<bf10c2dc>] (input_close_polled_device+0x0/0x74
>[input_polldev]) from [<c02b2458>] (input_close_device+0x58/0x7)
>[   89.415618]  r5:dfb618cc r4:dfb2b0c0
>[   89.419250] [<c02b2400>] (input_close_device+0x0/0x7c) from
>[<c02b4ab8>] (evdev_release+0x8c/0xa4)
>[   89.428253]  r7:df67e960 r6:dfb6193c r5:d1ca1080 r4:dfb618c0
>[   89.433990] [<c02b4a2c>] (evdev_release+0x0/0xa4) from [<c00ce2e0>]
>(__fput+0x130/0x258)
>[   89.442108]  r7:df67e960 r6:00000010 r5:cf408200 r4:00000000
>[   89.447845] [<c00ce1b0>] (__fput+0x0/0x258) from [<c00ce438>]
>(fput+0x30/0x34)
>[   89.455108] [<c00ce408>] (fput+0x0/0x34) from [<c00caa74>]
>(filp_close+0x78/0x84)
>[   89.462646] [<c00ca9fc>] (filp_close+0x0/0x84) from [<c005f8dc>]
>(put_files_struct+0x8c/0xf4)
>[   89.471221]  r7:0000000c r6:d3bca000 r5:00000000 r4:00000041
>[   89.476928] [<c005f850>] (put_files_struct+0x0/0xf4) from
>[<c005f984>] (exit_files+0x40/0x44)
>[   89.485504] [<c005f944>] (exit_files+0x0/0x44) from [<c0060fa8>]
>(do_exit+0x1cc/0x678)
>[   89.493469]  r7:00000002 r6:cf410000 r5:d34a1b00 r4:00000002
>[   89.499206] [<c0060ddc>] (do_exit+0x0/0x678) from [<c00614ec>]
>(do_group_exit+0x98/0xc8)
>[   89.507354] [<c0061454>] (do_group_exit+0x0/0xc8) from [<c006c218>]
>(get_signal_to_deliver+0x390/0x3d8)
>[   89.516784]  r7:cf410000 r6:be95167c r5:00000009 r4:c002e204
>[   89.522521] [<c006be88>] (get_signal_to_deliver+0x0/0x3d8) from
>[<c0030430>] (do_notify_resume+0x7c/0x594)
>[   89.532226] [<c00303b4>] (do_notify_resume+0x0/0x594) from
>[<c002e098>] (work_pending+0x1c/0x20)
>[   89.541076] Code: e5953000 e3d33003 0a000011 e593304c (e5934000)
>[   90.065185] ---[ end trace d28022cc252c43c3 ]---
>[   90.075866] Kernel panic - not syncing: Fatal exception
>
>I added traces to drivers/input/input-polldev.c
>static int input_open_polled_device(struct input_dev *input)
>{
>	struct input_polled_dev *dev = input_get_drvdata(input);
>	int error;
>	struct cpu_workqueue_struct *cwq;
>
>	printk("INPUT_OPEN_POLLED_DEVICE - enter\n");
>	printk("polldev_wq before start_workqueue: %x\n", polldev_wq);
>	if (polldev_wq != NULL)
>		printk("cpu_wq of wq: %x\n", polldev_wq->cpu_wq);
>
>
>	error = input_polldev_start_workqueue();
>	if (error)
>		return error;
>	printk("polldev_wq after start_workqueue: %x\n", polldev_wq);
>	if (polldev_wq != NULL)
>		printk("cpu_wq of wq: %x\n", polldev_wq->cpu_wq);
>
>	if (dev->open)
>		dev->open(dev);
>
>	printk("poll_interval: %x\n", dev->poll_interval );
>	printk("addr of work: %x\n", &dev->work);
>	cwq = atomic_long_read(&dev->work.work.data) &
>WORK_STRUCT_WQ_DATA_MASK;
>	printk("data (==cwq) at work (before queueing): %x\n", cwq);
>	if (cwq != NULL)
>		printk("wq from cwq: %x\n", cwq->wq);
>
>	/* Only start polling if polling is enabled */
>	if (dev->poll_interval > 0)
>		queue_delayed_work(polldev_wq, &dev->work, 0);
>
>	cwq = atomic_long_read(&dev->work.work.data) &
>WORK_STRUCT_WQ_DATA_MASK;
>	printk("data (==cwq) at work (after queueing): %x\n", cwq);
>	if (cwq != NULL)
>		printk("wq from cwq: %x\n", cwq->wq);
>
>	printk("INPUT_OPEN_POLLED_DEVICE - done\n");
>	return 0;
>}
>
>First time device open:
>[   29.094879] INPUT_OPEN_POLLED_DEVICE - enter
>[   29.099182] polldev_wq before start_workqueue: 0
>[   29.154449] polldev_wq after start_workqueue: ded3c580
>[   29.159637] cpu_wq of wq: dc4b8480
>[   29.255950] poll_interval: 32
>[   29.258941] addr of work: dfbe8f20
>[   29.262359] data (==cwq) at work (before queueing): 0
>[   29.267669] data (==cwq) at work (after queueing): dc4b8480  <-------
>CPU workqueue same as polldev_wq
>[   29.273315] wq from cwq: ded3c580
>[   29.276641] INPUT_OPEN_POLLED_DEVICE - done
>
>there were other devices opened and closed between
>
>Second time device open:
>[  202.372680] INPUT_OPEN_POLLED_DEVICE - enter
>[  202.377258] polldev_wq before start_workqueue: dc57ba00
>[  202.382598] cpu_wq of wq: dc4ea900
>[  202.386077] polldev_wq after start_workqueue: dc57ba00
>[  202.391326] cpu_wq of wq: dc4ea900
>[  202.459259] poll_interval: 0  <-------------------------------- no
>queueing because of this
>[  202.462188] addr of work: dfbe8f20
>[  202.465637] data (==cwq) at work (before queueing): dc4b8480  <------
>----- CPU workqueue not updated.
>[  202.471435] wq from cwq: 6b6b006f
>[  202.474853] data (==cwq) at work (after queueing): dc4b8480 <-----
>queueing not done -> not updated
>[  202.480468] wq from cwq: 6b6b006f <-------------------------- crap
>[  202.483886] INPUT_OPEN_POLLED_DEVICE - done
>
>And when cancel_delayed_work_sync is called, kernel crashes due to crap
>address to per-cpu workqueue.
>
>Actually problem is that "data" field in the work struct points to the
>non-existing per-cpu workqueue entry.
>When this is cancelled at device close, kernel crashes. But what is the
>root cause? In input-polldev,
>workqueue can change from time to time depending on what happens at the
>userspace. Work struct
>can still contain references to the old workqueue. Is that illegal thing
>to do?
>Or should cancellation of the work cleanup the work struct so that it is
>in initial state.
>
>It is said in the workqueue.c:
>* The caller must ensure that workqueue_struct on which this work was
>last
> * queued can't be destroyed before this function returns.
>
>This is not true here. Workqueue has been destroyed since the work has
>never queued to the new workqueue.
>Either cancel_(delayed)_work_sync should clear the data field instead of
>setting it to non-pending or
>input-polldev must clear the work struct in case of no queueing. Or do
>you have other proposals?
>

One solution is not to destroy and recreate workqueue in input-polldev
based on open / close calls. This way references to workqueue stays valid.

-Samu

