From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fwd: Potential data race in psmouse_interrupt
Date: Wed, 22 Jul 2015 09:52:13 -0700
Message-ID: <20150722165213.GB14875@dtor-ws>
References: <CAAeHK+wZ=fXCRDUvkQdSmFWxU1fqN5suF=P1kL_CT1L8p3ybDg@mail.gmail.com>
 <CAAeHK+wmUwTG=4afGd+LHw7FCcnjsRZY7j_3XnvUYna2Qkx-+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36825 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965304AbbGVQwS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 12:52:18 -0400
Content-Disposition: inline
In-Reply-To: <CAAeHK+wmUwTG=4afGd+LHw7FCcnjsRZY7j_3XnvUYna2Qkx-+A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Shailendra Verma <shailendra.capricorn@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, ktsan@googlegroups.com

On Wed, Jul 22, 2015 at 03:14:42PM +0200, Andrey Konovalov wrote:
> Hi!
> 
> We are working on a dynamic data race detector for Linux kernel called
> KernelThreadSanitizer (ktsan) (https://github.com/google/ktsan/wiki).
> 
> Here is a report we got while running ktsan (upstream revision
> 21bdb584af8cca7c6df3c44cba268be050a234eb).
> 
> ==================================================================
> ThreadSanitizer: data-race in psmouse_interrupt
> 
> Write of size 1 by thread T1 (K1):
>  [<ffffffff819d5272>] psmouse_interrupt+0xd2/0x690
> drivers/input/mouse/psmouse-base.c:337
>  [<ffffffff819bcd16>] serio_interrupt+0x66/0xb0 drivers/input/serio/serio.c:1008
>  [<ffffffff819be5f0>] i8042_interrupt+0x240/0x4d0
> drivers/input/serio/i8042.c:541
>  [<ffffffff810f03b2>] handle_irq_event_percpu+0x62/0x2a0 kernel/irq/handle.c:143
>  [<ffffffff810f0692>] handle_irq_event+0xa2/0xf0 kernel/irq/handle.c:192
>  [<ffffffff810f5414>] handle_edge_irq+0x104/0x380 kernel/irq/chip.c:608
>  [<     inlined    >] handle_irq+0xf6/0x220 generic_handle_irq_desc
> include/linux/irqdesc.h:146
>  [<ffffffff81009f86>] handle_irq+0xf6/0x220 arch/x86/kernel/irq_64.c:81
>  [<ffffffff810093ce>] do_IRQ+0x5e/0x110 arch/x86/kernel/irq.c:223
>  [<ffffffff81e726ab>] ret_from_intr+0x0/0x1f arch/x86/entry/entry_64.S:601
>  [<     inlined    >] irq_exit+0x98/0xa0 invoke_softirq kernel/softirq.c:350
>  [<ffffffff8108edd8>] irq_exit+0x98/0xa0 kernel/softirq.c:391
>  [<     inlined    >] smp_apic_timer_interrupt+0x63/0x80 exiting_irq
> ./arch/x86/include/asm/apic.h:655
>  [<ffffffff8105c503>] smp_apic_timer_interrupt+0x63/0x80
> arch/x86/kernel/apic/apic.c:915
>  [<ffffffff81e7299b>] apic_timer_interrupt+0x6b/0x70
> arch/x86/entry/entry_64.S:782
>  [<ffffffff8153223d>] kvasprintf+0x5d/0x90 lib/kasprintf.c:24
>  [<ffffffff815322be>] kasprintf+0x4e/0x70 lib/kasprintf.c:40
>  [<     inlined    >] module_add_driver+0x8f/0x180 make_driver_name
> drivers/base/module.c:18
>  [<ffffffff8183059f>] module_add_driver+0x8f/0x180 drivers/base/module.c:63
>  [<ffffffff81812c94>] bus_add_driver+0x204/0x340 drivers/base/bus.c:713
>  [<ffffffff81814e2b>] driver_register+0xdb/0x190 drivers/base/driver.c:168
>  [<ffffffff81a5ed16>] __hid_register_driver+0xb6/0x100
> drivers/hid/hid-core.c:2677
>  [<ffffffff825ab67d>] apple_driver_init+0x24/0x31 drivers/hid/hid-apple.c:574
>  [<ffffffff81000339>] do_one_initcall+0xb9/0x220 init/main.c:798
>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397
> do_initcall_level init/main.c:863
>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397 do_initcalls
> init/main.c:871
>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397 do_basic_setup
> init/main.c:890
>  [<ffffffff8253d919>] kernel_init_freeable+0x2ca/0x397 init/main.c:1013
>  [<ffffffff81e5ad66>] kernel_init+0x16/0x140 init/main.c:941
>  [<ffffffff81e71f5f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:526
> DBG: cpu = ffff88053fd9fe68
> DBG: cpu id = 3
> 
> Previous read of size 1 by thread T509 (K506):
>  [<     inlined    >] cypress_send_ext_cmd+0x193/0x500
> cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:123
>  [<ffffffff819e6b23>] cypress_send_ext_cmd+0x193/0x500
> drivers/input/mouse/cypress_ps2.c:192
>  [<ffffffff819e6f5a>] cypress_detect+0x2a/0xb0
> drivers/input/mouse/cypress_ps2.c:208
>  [<ffffffff819d5e66>] psmouse_extensions+0x1f6/0x4e0
> drivers/input/mouse/psmouse-base.c:849 (discriminator 1)
>  [<ffffffff819d63fd>] psmouse_switch_protocol+0x2ad/0x330
> drivers/input/mouse/psmouse-base.c:1467
>  [<ffffffff819d7426>] psmouse_connect+0x2e6/0x450
> drivers/input/mouse/psmouse-base.c:1554 (discriminator 4)
>  [<     inlined    >] serio_driver_probe+0x57/0x80
> serio_connect_driver drivers/input/serio/serio.c:65
>  [<ffffffff819bcf77>] serio_driver_probe+0x57/0x80
> drivers/input/serio/serio.c:796
>  [<     inlined    >] driver_probe_device+0x1da/0x460 really_probe
> drivers/base/dd.c:308
>  [<ffffffff81813b1a>] driver_probe_device+0x1da/0x460 drivers/base/dd.c:414
>  [<ffffffff81813e64>] __driver_attach+0xc4/0xd0 drivers/base/dd.c:612
>  [<ffffffff81810933>] bus_for_each_dev+0x93/0xe0 drivers/base/bus.c:314
>  [<ffffffff81813353>] driver_attach+0x33/0x50 drivers/base/dd.c:631
>  [<     inlined    >] serio_handle_event+0x2d3/0x3b0
> serio_attach_driver drivers/input/serio/serio.c:826
>  [<ffffffff819bd8e3>] serio_handle_event+0x2d3/0x3b0
> drivers/input/serio/serio.c:245
>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueue.c:2036
>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:2170
>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
>  [<ffffffff81e71f5f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:526
> DBG: cpu = 0
> 
> DBG: addr: ffff88019d703909
> DBG: first offset: 1, second offset: 1
> DBG: T1 clock: {T1: 17075020, T509: 142163}
> DBG: T509 clock: {T509: 142167}
> ==================================================================
> 
> It seems that accessing 'psmouse->pktcnt' in
> 'psmouse->packet[psmouse->pktcnt++] = data' in 'psmouse_interrupt()'
> is racing with 'wait_event_timeout(ps2dev->wait, (psmouse->pktcnt >=
> pktsize), msecs_to_jiffies(CYTP_CMD_TIMEOUT))' in
> 'cypress_ps2_read_cmd_status()'.
> If that's the case, it's possible that 'psmouse->pktcnt' is
> incremented, but no data is written yet, so '(psmouse->pktcnt >=
> pktsize)' will evaluate to true and the following 'memcpy' will access
> invalid data.
> 
> Could you confirm if this is a real data race?

Yes, looks like real positive.

Thanks.

-- 
Dmitry
