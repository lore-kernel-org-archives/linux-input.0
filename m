From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Potential data race in psmouse_interrupt
Date: Wed, 29 Jul 2015 13:53:26 +0200
Message-ID: <20150729115326.GE13518@pali>
References: <CAAeHK+wZ=fXCRDUvkQdSmFWxU1fqN5suF=P1kL_CT1L8p3ybDg@mail.gmail.com>
 <CAAeHK+wmUwTG=4afGd+LHw7FCcnjsRZY7j_3XnvUYna2Qkx-+A@mail.gmail.com>
 <20150723130844.GA29125@pali>
 <CAAeHK+xyvq3XnN2FZuO35i+DBDYoi1OFWvHmAdZmC=k7kq9q5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35752 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbG2Lxa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 07:53:30 -0400
Content-Disposition: inline
In-Reply-To: <CAAeHK+xyvq3XnN2FZuO35i+DBDYoi1OFWvHmAdZmC=k7kq9q5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Mathias Gottschlag <mgottschlag@gmail.com>, Shailendra Verma <shailendra.capricorn@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, "Luis R. Rodriguez" <mcgrof@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, ktsan@googlegroups.com

Hi! This log looks like there can be race condition in initialization
code, but not in receiving ALPS packets after initialization...

On Thursday 23 July 2015 15:31:46 Andrey Konovalov wrote:
> Hi Pali,
>=20
> There are a few reports in psmouse-base.c/alps.c code as well.
> Here is a couple of them that are printed one right after another.
> The second one tells about a race on ps2dev->cmdcnt.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ThreadSanitizer: data-race in ps2_handle_ack
>=20
> Write of size 8 by thread T6 (K6):
>  [<ffffffff819c0b83>] ps2_handle_ack+0xf3/0x180 drivers/input/serio/l=
ibps2.c:322
>  [<ffffffff819d55d7>] psmouse_interrupt+0x207/0x690
> drivers/input/mouse/psmouse-base.c:317
>  [<ffffffff819bcf46>] serio_interrupt+0x66/0xb0 drivers/input/serio/s=
erio.c:1008
>  [<ffffffff819be820>] i8042_interrupt+0x240/0x4d0
> drivers/input/serio/i8042.c:541
>  [<ffffffff810f03b2>] handle_irq_event_percpu+0x62/0x2a0 kernel/irq/h=
andle.c:143
>  [<ffffffff810f0692>] handle_irq_event+0xa2/0xf0 kernel/irq/handle.c:=
192
>  [<ffffffff810f5414>] handle_edge_irq+0x104/0x380 kernel/irq/chip.c:6=
08
>  [<     inlined    >] handle_irq+0xf6/0x220 generic_handle_irq_desc
> include/linux/irqdesc.h:146
>  [<ffffffff81009f86>] handle_irq+0xf6/0x220 arch/x86/kernel/irq_64.c:=
81
>  [<ffffffff810093ce>] do_IRQ+0x5e/0x110 arch/x86/kernel/irq.c:223
>  [<ffffffff81e728ab>] ret_from_intr+0x0/0x1f arch/x86/entry/entry_64.=
S:601
>  [<     inlined    >] irq_exit+0x98/0xa0 invoke_softirq kernel/softir=
q.c:350
>  [<ffffffff8108edd8>] irq_exit+0x98/0xa0 kernel/softirq.c:391
>  [<     inlined    >] smp_apic_timer_interrupt+0x63/0x80 exiting_irq
> ./arch/x86/include/asm/apic.h:655
>  [<ffffffff8105c503>] smp_apic_timer_interrupt+0x63/0x80
> arch/x86/kernel/apic/apic.c:915
>  [<ffffffff81e72b9b>] apic_timer_interrupt+0x6b/0x70
> arch/x86/entry/entry_64.S:782
>  [<ffffffff81086fe3>] _do_fork+0x133/0x500 kernel/fork.c:1719
>  [<ffffffff810873ec>] kernel_thread+0x3c/0x60 kernel/fork.c:1772
>  [<ffffffff810a71dc>] __call_usermodehelper+0x5c/0x90 kernel/kmod.c:3=
17
>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueue.c=
:2036
>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:217=
0
>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
>  [<ffffffff81e7215f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64=
=2ES:526
> DBG: cpu =3D ffff88053fd9fe68
> DBG: cpu id =3D 3
>=20
> Previous read of size 8 by thread T397 (K394):
>  [<ffffffff819c0cf2>] ps2_sendbyte+0xe2/0x210 drivers/input/serio/lib=
ps2.c:45
>  [<ffffffff819c1109>] __ps2_command+0x159/0x660 drivers/input/serio/l=
ibps2.c:214
>  [<ffffffff819c1645>] ps2_command+0x35/0x60 drivers/input/serio/libps=
2.c:260
>  [<ffffffff819dd412>] alps_rpt_cmd+0x42/0xe0
> drivers/input/mouse/alps.c:1665 (discriminator 1)
>  [<ffffffff819e12b6>] alps_identify+0x36/0xc80 drivers/input/mouse/al=
ps.c:2690
>  [<ffffffff819e3498>] alps_detect+0x28/0x150 drivers/input/mouse/alps=
=2Ec:2960
>  [<     inlined    >] psmouse_extensions+0x25e/0x4e0 psmouse_do_detec=
t
> drivers/input/mouse/psmouse-base.c:752
>  [<ffffffff819d60fe>] psmouse_extensions+0x25e/0x4e0
> drivers/input/mouse/psmouse-base.c:870
>  [<ffffffff819d662d>] psmouse_switch_protocol+0x2ad/0x330
> drivers/input/mouse/psmouse-base.c:1467
>  [<ffffffff819d7656>] psmouse_connect+0x2e6/0x450
> drivers/input/mouse/psmouse-base.c:1554 (discriminator 4)
>  [<     inlined    >] serio_driver_probe+0x57/0x80
> serio_connect_driver drivers/input/serio/serio.c:65
>  [<ffffffff819bd1a7>] serio_driver_probe+0x57/0x80
> drivers/input/serio/serio.c:796
>  [<     inlined    >] driver_probe_device+0x1da/0x460 really_probe
> drivers/base/dd.c:308
>  [<ffffffff81813d4a>] driver_probe_device+0x1da/0x460 drivers/base/dd=
=2Ec:414
>  [<ffffffff81814094>] __driver_attach+0xc4/0xd0 drivers/base/dd.c:612
>  [<ffffffff81810b63>] bus_for_each_dev+0x93/0xe0 drivers/base/bus.c:3=
14
>  [<ffffffff81813583>] driver_attach+0x33/0x50 drivers/base/dd.c:631
>  [<     inlined    >] serio_handle_event+0x2d3/0x3b0
> serio_attach_driver drivers/input/serio/serio.c:826
>  [<ffffffff819bdb13>] serio_handle_event+0x2d3/0x3b0
> drivers/input/serio/serio.c:245
>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueue.c=
:2036
>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:217=
0
>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
>  [<ffffffff81e7215f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64=
=2ES:526
> DBG: cpu =3D 0
>=20
> DBG: addr: ffff88019a923a58
> DBG: first offset: 0, second offset: 0
> DBG: T6 clock: {T6: 2264295, T397: 174118}
> DBG: T397 clock: {T397: 174122}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ThreadSanitizer: data-race in __ps2_command
>=20
> Read of size 1 by thread T397 (K394):
>  [<ffffffff819c1220>] __ps2_command+0x270/0x660
> drivers/input/serio/libps2.c:230 (discriminator 21)
>  [<ffffffff819c1645>] ps2_command+0x35/0x60 drivers/input/serio/libps=
2.c:260
>  [<ffffffff819dd47e>] alps_rpt_cmd+0xae/0xe0 drivers/input/mouse/alps=
=2Ec:1674
>  [<ffffffff819e12b6>] alps_identify+0x36/0xc80 drivers/input/mouse/al=
ps.c:2690
>  [<ffffffff819e3498>] alps_detect+0x28/0x150 drivers/input/mouse/alps=
=2Ec:2960
>  [<     inlined    >] psmouse_extensions+0x25e/0x4e0 psmouse_do_detec=
t
> drivers/input/mouse/psmouse-base.c:752
>  [<ffffffff819d60fe>] psmouse_extensions+0x25e/0x4e0
> drivers/input/mouse/psmouse-base.c:870
>  [<ffffffff819d662d>] psmouse_switch_protocol+0x2ad/0x330
> drivers/input/mouse/psmouse-base.c:1467
>  [<ffffffff819d7656>] psmouse_connect+0x2e6/0x450
> drivers/input/mouse/psmouse-base.c:1554 (discriminator 4)
>  [<     inlined    >] serio_driver_probe+0x57/0x80
> serio_connect_driver drivers/input/serio/serio.c:65
>  [<ffffffff819bd1a7>] serio_driver_probe+0x57/0x80
> drivers/input/serio/serio.c:796
>  [<     inlined    >] driver_probe_device+0x1da/0x460 really_probe
> drivers/base/dd.c:308
>  [<ffffffff81813d4a>] driver_probe_device+0x1da/0x460 drivers/base/dd=
=2Ec:414
>  [<ffffffff81814094>] __driver_attach+0xc4/0xd0 drivers/base/dd.c:612
>  [<ffffffff81810b63>] bus_for_each_dev+0x93/0xe0 drivers/base/bus.c:3=
14
>  [<ffffffff81813583>] driver_attach+0x33/0x50 drivers/base/dd.c:631
>  [<     inlined    >] serio_handle_event+0x2d3/0x3b0
> serio_attach_driver drivers/input/serio/serio.c:826
>  [<ffffffff819bdb13>] serio_handle_event+0x2d3/0x3b0
> drivers/input/serio/serio.c:245
>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueue.c=
:2036
>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:217=
0
>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
>  [<ffffffff81e7215f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64=
=2ES:526
> DBG: cpu =3D ffff88053fc9fe68
> DBG: cpu id =3D 1
>=20
> Previous write of size 1 by thread T6 (K6):
>  [<ffffffff819c09a6>] ps2_handle_response+0x46/0x130
> drivers/input/serio/libps2.c:346
>  [<ffffffff819d58a4>] psmouse_interrupt+0x4d4/0x690
> drivers/input/mouse/psmouse-base.c:321
>  [<ffffffff819bcf46>] serio_interrupt+0x66/0xb0 drivers/input/serio/s=
erio.c:1008
>  [<ffffffff819be820>] i8042_interrupt+0x240/0x4d0
> drivers/input/serio/i8042.c:541
>  [<ffffffff810f03b2>] handle_irq_event_percpu+0x62/0x2a0 kernel/irq/h=
andle.c:143
>  [<ffffffff810f0692>] handle_irq_event+0xa2/0xf0 kernel/irq/handle.c:=
192
>  [<ffffffff810f5414>] handle_edge_irq+0x104/0x380 kernel/irq/chip.c:6=
08
>  [<     inlined    >] handle_irq+0xf6/0x220 generic_handle_irq_desc
> include/linux/irqdesc.h:146
>  [<ffffffff81009f86>] handle_irq+0xf6/0x220 arch/x86/kernel/irq_64.c:=
81
>  [<ffffffff810093ce>] do_IRQ+0x5e/0x110 arch/x86/kernel/irq.c:223
>  [<ffffffff81e728ab>] ret_from_intr+0x0/0x1f arch/x86/entry/entry_64.=
S:601
>  [<ffffffff81e72b9b>] apic_timer_interrupt+0x6b/0x70
> arch/x86/entry/entry_64.S:782
>  [<     inlined    >] kvm_clock_get_cycles+0x3e/0x50 kvm_clock_read
> arch/x86/kernel/kvmclock.c:85
>  [<ffffffff8106e74e>] kvm_clock_get_cycles+0x3e/0x50
> arch/x86/kernel/kvmclock.c:92
>  [<     inlined    >] ktime_get_with_offset+0x99/0x180
> timekeeping_get_delta kernel/time/timekeeping.c:210
>  [<     inlined    >] ktime_get_with_offset+0x99/0x180
> timekeeping_get_ns kernel/time/timekeeping.c:306
>  [<ffffffff81114da9>] ktime_get_with_offset+0x99/0x180
> kernel/time/timekeeping.c:720
>  [<     inlined    >] copy_process.part.44+0x773/0x2c40
> ktime_get_boottime include/linux/timekeeping.h:183
>  [<     inlined    >] copy_process.part.44+0x773/0x2c40
> ktime_get_boot_ns include/linux/timekeeping.h:214
>  [<ffffffff810848b3>] copy_process.part.44+0x773/0x2c40 kernel/fork.c=
:1363
>  [<     inlined    >] _do_fork+0x103/0x500 copy_process kernel/fork.c=
:1261
>  [<ffffffff81086fb3>] _do_fork+0x103/0x500 kernel/fork.c:1709
>  [<ffffffff810873ec>] kernel_thread+0x3c/0x60 kernel/fork.c:1772
>  [<ffffffff810a71dc>] __call_usermodehelper+0x5c/0x90 kernel/kmod.c:3=
17
>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueue.c=
:2036
>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:217=
0
>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
>  [<ffffffff81e7215f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64=
=2ES:526
> DBG: cpu =3D 0
>=20
> DBG: addr: ffff88019a923a68
> DBG: first offset: 0, second offset: 0
> DBG: T397 clock: {T397: 175738, T6: 2266233}
> DBG: T6 clock: {T6: 2266336}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> On Thu, Jul 23, 2015 at 3:08 PM, Pali Roh=C3=A1r <pali.rohar@gmail.co=
m> wrote:
> > On Wednesday 22 July 2015 15:14:42 Andrey Konovalov wrote:
> >> Hi!
> >>
> >> We are working on a dynamic data race detector for Linux kernel ca=
lled
> >> KernelThreadSanitizer (ktsan) (https://github.com/google/ktsan/wik=
i).
> >>
> >> Here is a report we got while running ktsan (upstream revision
> >> 21bdb584af8cca7c6df3c44cba268be050a234eb).
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> ThreadSanitizer: data-race in psmouse_interrupt
> >>
> >> Write of size 1 by thread T1 (K1):
> >>  [<ffffffff819d5272>] psmouse_interrupt+0xd2/0x690
> >> drivers/input/mouse/psmouse-base.c:337
> >>  [<ffffffff819bcd16>] serio_interrupt+0x66/0xb0 drivers/input/seri=
o/serio.c:1008
> >>  [<ffffffff819be5f0>] i8042_interrupt+0x240/0x4d0
> >> drivers/input/serio/i8042.c:541
> >>  [<ffffffff810f03b2>] handle_irq_event_percpu+0x62/0x2a0 kernel/ir=
q/handle.c:143
> >>  [<ffffffff810f0692>] handle_irq_event+0xa2/0xf0 kernel/irq/handle=
=2Ec:192
> >>  [<ffffffff810f5414>] handle_edge_irq+0x104/0x380 kernel/irq/chip.=
c:608
> >>  [<     inlined    >] handle_irq+0xf6/0x220 generic_handle_irq_des=
c
> >> include/linux/irqdesc.h:146
> >>  [<ffffffff81009f86>] handle_irq+0xf6/0x220 arch/x86/kernel/irq_64=
=2Ec:81
> >>  [<ffffffff810093ce>] do_IRQ+0x5e/0x110 arch/x86/kernel/irq.c:223
> >>  [<ffffffff81e726ab>] ret_from_intr+0x0/0x1f arch/x86/entry/entry_=
64.S:601
> >>  [<     inlined    >] irq_exit+0x98/0xa0 invoke_softirq kernel/sof=
tirq.c:350
> >>  [<ffffffff8108edd8>] irq_exit+0x98/0xa0 kernel/softirq.c:391
> >>  [<     inlined    >] smp_apic_timer_interrupt+0x63/0x80 exiting_i=
rq
> >> ./arch/x86/include/asm/apic.h:655
> >>  [<ffffffff8105c503>] smp_apic_timer_interrupt+0x63/0x80
> >> arch/x86/kernel/apic/apic.c:915
> >>  [<ffffffff81e7299b>] apic_timer_interrupt+0x6b/0x70
> >> arch/x86/entry/entry_64.S:782
> >>  [<ffffffff8153223d>] kvasprintf+0x5d/0x90 lib/kasprintf.c:24
> >>  [<ffffffff815322be>] kasprintf+0x4e/0x70 lib/kasprintf.c:40
> >>  [<     inlined    >] module_add_driver+0x8f/0x180 make_driver_nam=
e
> >> drivers/base/module.c:18
> >>  [<ffffffff8183059f>] module_add_driver+0x8f/0x180 drivers/base/mo=
dule.c:63
> >>  [<ffffffff81812c94>] bus_add_driver+0x204/0x340 drivers/base/bus.=
c:713
> >>  [<ffffffff81814e2b>] driver_register+0xdb/0x190 drivers/base/driv=
er.c:168
> >>  [<ffffffff81a5ed16>] __hid_register_driver+0xb6/0x100
> >> drivers/hid/hid-core.c:2677
> >>  [<ffffffff825ab67d>] apple_driver_init+0x24/0x31 drivers/hid/hid-=
apple.c:574
> >>  [<ffffffff81000339>] do_one_initcall+0xb9/0x220 init/main.c:798
> >>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397
> >> do_initcall_level init/main.c:863
> >>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397 do_initcall=
s
> >> init/main.c:871
> >>  [<     inlined    >] kernel_init_freeable+0x2ca/0x397 do_basic_se=
tup
> >> init/main.c:890
> >>  [<ffffffff8253d919>] kernel_init_freeable+0x2ca/0x397 init/main.c=
:1013
> >>  [<ffffffff81e5ad66>] kernel_init+0x16/0x140 init/main.c:941
> >>  [<ffffffff81e71f5f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry=
_64.S:526
> >> DBG: cpu =3D ffff88053fd9fe68
> >> DBG: cpu id =3D 3
> >>
> >> Previous read of size 1 by thread T509 (K506):
> >>  [<     inlined    >] cypress_send_ext_cmd+0x193/0x500
> >> cypress_ps2_read_cmd_status drivers/input/mouse/cypress_ps2.c:123
> >>  [<ffffffff819e6b23>] cypress_send_ext_cmd+0x193/0x500
> >> drivers/input/mouse/cypress_ps2.c:192
> >>  [<ffffffff819e6f5a>] cypress_detect+0x2a/0xb0
> >> drivers/input/mouse/cypress_ps2.c:208
> >>  [<ffffffff819d5e66>] psmouse_extensions+0x1f6/0x4e0
> >> drivers/input/mouse/psmouse-base.c:849 (discriminator 1)
> >>  [<ffffffff819d63fd>] psmouse_switch_protocol+0x2ad/0x330
> >> drivers/input/mouse/psmouse-base.c:1467
> >>  [<ffffffff819d7426>] psmouse_connect+0x2e6/0x450
> >> drivers/input/mouse/psmouse-base.c:1554 (discriminator 4)
> >>  [<     inlined    >] serio_driver_probe+0x57/0x80
> >> serio_connect_driver drivers/input/serio/serio.c:65
> >>  [<ffffffff819bcf77>] serio_driver_probe+0x57/0x80
> >> drivers/input/serio/serio.c:796
> >>  [<     inlined    >] driver_probe_device+0x1da/0x460 really_probe
> >> drivers/base/dd.c:308
> >>  [<ffffffff81813b1a>] driver_probe_device+0x1da/0x460 drivers/base=
/dd.c:414
> >>  [<ffffffff81813e64>] __driver_attach+0xc4/0xd0 drivers/base/dd.c:=
612
> >>  [<ffffffff81810933>] bus_for_each_dev+0x93/0xe0 drivers/base/bus.=
c:314
> >>  [<ffffffff81813353>] driver_attach+0x33/0x50 drivers/base/dd.c:63=
1
> >>  [<     inlined    >] serio_handle_event+0x2d3/0x3b0
> >> serio_attach_driver drivers/input/serio/serio.c:826
> >>  [<ffffffff819bd8e3>] serio_handle_event+0x2d3/0x3b0
> >> drivers/input/serio/serio.c:245
> >>  [<ffffffff810adcf9>] process_one_work+0x2a9/0x6d0 kernel/workqueu=
e.c:2036
> >>  [<ffffffff810aeddf>] worker_thread+0xbf/0x710 kernel/workqueue.c:=
2170
> >>  [<ffffffff810b700c>] kthread+0x15c/0x180 kernel/kthread.c:207
> >>  [<ffffffff81e71f5f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry=
_64.S:526
> >> DBG: cpu =3D 0
> >>
> >> DBG: addr: ffff88019d703909
> >> DBG: first offset: 1, second offset: 1
> >> DBG: T1 clock: {T1: 17075020, T509: 142163}
> >> DBG: T509 clock: {T509: 142167}
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> It seems that accessing 'psmouse->pktcnt' in
> >> 'psmouse->packet[psmouse->pktcnt++] =3D data' in 'psmouse_interrup=
t()'
> >> is racing with 'wait_event_timeout(ps2dev->wait, (psmouse->pktcnt =
>=3D
> >> pktsize), msecs_to_jiffies(CYTP_CMD_TIMEOUT))' in
> >> 'cypress_ps2_read_cmd_status()'.
> >> If that's the case, it's possible that 'psmouse->pktcnt' is
> >> incremented, but no data is written yet, so '(psmouse->pktcnt >=3D
> >> pktsize)' will evaluate to true and the following 'memcpy' will ac=
cess
> >> invalid data.
> >>
> >> Could you confirm if this is a real data race?
> >>
> >> Thanks in advance!
> >>
> >
> > Hi Andrey,
> >
> > I would like to ask you, did not you noticed some problem from Sani=
tizer
> > with psmouse-base.c and alps.c code?
> >
> > There is unknown problem when alps.c receive invalid data from
> > psmouse_interrupt/serio_interrupt/i8042_interrupt.
> >
> > And when I read your email with race condition & accesing invalid d=
ata
> > in cypress driver. I'm thinking if there cannot be something like t=
hat.
> >
> > --
> > Pali Roh=C3=A1r
> > pali.rohar@gmail.com

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
