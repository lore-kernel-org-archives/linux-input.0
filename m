From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Mon, 11 Sep 2017 17:15:02 +0200
Message-ID: <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com>
References: <CAAeHK+y-gycNCJv3XEZ4hwv_BndB590UWVqCYWd-Y8URDbH+vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org
Cc: Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 11, 2017 at 3:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, 11 Sep 2017, Andrey Konovalov wrote:
>
>> Hi!
>>
>> I've been getting stall reports like this one while fuzzing the USB
>> stack with gadgetfs. I'm wondering whether this is a bug in gadgetfs
>> or is this report induced by the changes I've made to the USB core
>> code. I didn't touch gadgetfs code though (except for adding a few
>> printk's).
>>
>> I'm on commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432
>
> It's possible that this was caused by commit f16443a034c7 ("USB:
> gadgetfs, dummy-hcd, net2280: fix locking for callbacks").  I've been
> meaning to repair the commit but haven't done it yet.
>
> Can you test with that commit reverted?  You may end up seeing other
> problems instead -- the ones that commit was intended to solve -- but
> perhaps the stalls won't occur.

So I've reverted both: the changes I made to USB core and the commit
you mentioned, still saw the stalls.

I've manged to find a way to reproduce this and now I'm not sure the
problem is actually in gadgetfs, it might be the usbtouchscreen
driver.

The crash log is below.

Thanks!

gadgetfs: bound to dummy_udc driver
usb 1-1: new full-speed USB device number 2 using dummy_hcd
gadgetfs: connected
gadgetfs: disconnected
gadgetfs: connected
usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has an
invalid bInterval 0, changing to 10
usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has invalid
maxpacket 839, setting to 64
usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x7 has invalid
maxpacket 1839, setting to 64
usb 1-1: config 8 interface 0 has no altsetting 0
usb 1-1: New USB device found, idVendor=0403, idProduct=f9e9
usb 1-1: New USB device strings: Mfr=4, Product=8, SerialNumber=255
usb 1-1: Product: a
usb 1-1: Manufacturer: a
usb 1-1: SerialNumber: a
gadgetfs: configuration #8
input: a a as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:8.0/input/input8
evbug: Connected device: input8 (a a at usb-dummy_hcd.0-1/input0)
kworker/0:0: page allocation failure: order:0,
mode:0x1280020(GFP_ATOMIC|__GFP_NOTRACK), nodemask=(null)
kworker/0:0 cpuset=/ mems_allowed=0
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.13.0+ #93
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x192/0x22c lib/dump_stack.c:52
 warn_alloc+0x28e/0x430 mm/page_alloc.c:3242
 __alloc_pages_slowpath+0x1bbc/0x2250 mm/page_alloc.c:4043
 __alloc_pages_nodemask+0x914/0xea0 mm/page_alloc.c:4135
 alloc_pages_current+0xbb/0x1f0 mm/mempolicy.c:1974
 alloc_pages ./include/linux/gfp.h:507
 alloc_slab_page mm/slub.c:1408
 allocate_slab mm/slub.c:1559
 new_slab+0x384/0x410 mm/slub.c:1638
 new_slab_objects mm/slub.c:2423
 ___slab_alloc+0x35d/0x4c0 mm/slub.c:2575
 __slab_alloc+0x20/0x40 mm/slub.c:2615
 slab_alloc_node mm/slub.c:2678
 slab_alloc mm/slub.c:2720
 kmem_cache_alloc_trace+0x14e/0x170 mm/slub.c:2737
 kmalloc ./include/linux/slab.h:493
 dummy_urb_enqueue+0xf3/0x970 drivers/usb/gadget/udc/dummy_hcd.c:1220
 usb_hcd_submit_urb+0x2d3/0x1d50 drivers/usb/core/hcd.c:1664
 usb_submit_urb+0x937/0x11d0 drivers/usb/core/urb.c:542
 usbtouch_irq+0x216/0x2e0 drivers/input/touchscreen/usbtouchscreen.c:1441
 __usb_hcd_giveback_urb+0x2a1/0x5b0 drivers/usb/core/hcd.c:1779
 usb_hcd_giveback_urb+0x34f/0x4d0 drivers/usb/core/hcd.c:1845
 dummy_timer+0xbda/0x38c0 drivers/usb/gadget/udc/dummy_hcd.c:1924
 call_timer_fn+0xba/0x390 kernel/time/timer.c:1281
 expire_timers kernel/time/timer.c:1320
 __run_timers+0x9d0/0xda0 kernel/time/timer.c:1620
 run_timer_softirq+0x51/0xb0 kernel/time/timer.c:1646
 __do_softirq+0x258/0x7ac kernel/softirq.c:284
 invoke_softirq kernel/softirq.c:364
 irq_exit+0x14e/0x180 kernel/softirq.c:405
 exiting_irq ./arch/x86/include/asm/apic.h:638
 smp_apic_timer_interrupt+0x7b/0xa0 arch/x86/kernel/apic/apic.c:1044
 apic_timer_interrupt+0x89/0x90
RIP: 0010:arch_local_irq_restore ./arch/x86/include/asm/paravirt.h:814
RIP: 0010:console_unlock+0x814/0xcd0 kernel/printk/printk.c:2247
RSP: 0018:ffff88006bdedd30 EFLAGS: 00000a06 ORIG_RAX: ffffffffffffff10
RAX: 1ffff1000d7bdbe8 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1ffff1000d7bdbe0 RSI: ffffffff87f007c0 RDI: 0000000000000a06
RBP: ffff88006bdee0a8 R08: fffffbfff0fe0102 R09: fffffbfff0fe0102
R10: 0000000000000009 R11: fffffbfff0fe0101 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff82d15610
 </IRQ>
 vprintk_emit+0x567/0x5d0 kernel/printk/printk.c:1769
 vprintk_default+0x2d/0x40 kernel/printk/printk.c:1808
 vprintk_func+0x5c/0xd0 kernel/printk/printk_safe.c:382
 printk+0xcd/0xfe kernel/printk/printk.c:1841
 evbug_connect+0x1de/0x260 drivers/input/evbug.c:69
 input_attach_handler+0x59a/0x740 drivers/input/input.c:1002
 input_register_device+0xcb8/0xf90 drivers/input/input.c:2159
 usbtouch_probe+0x1372/0x1fe0 drivers/input/touchscreen/usbtouchscreen.c:1690
 usb_probe_interface+0x351/0x8d0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_set_configuration+0x1064/0x1890 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4890
 hub_port_connect_change drivers/usb/core/hub.c:4996
 port_event drivers/usb/core/hub.c:5102
 hub_event+0x23c8/0x37c0 drivers/usb/core/hub.c:5182
 process_one_work+0x9fb/0x1570 kernel/workqueue.c:2097
 worker_thread+0x1e4/0x1350 kernel/workqueue.c:2231
 kthread+0x324/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
Mem-Info:
active_anon:3514 inactive_anon:44 isolated_anon:0
 active_file:3194 inactive_file:2879 isolated_file:0
 unevictable:0 dirty:1474 writeback:0 unstable:0
 slab_reclaimable:2749 slab_unreclaimable:379894
 mapped:19353 shmem:52 pagetables:363 bounce:0
 free:2071 free_pcp:247 free_cma:0
Node 0 active_anon:14056kB inactive_anon:176kB active_file:12776kB
inactive_file:11516kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB mapped:77412kB dirty:5896kB writeback:0kB
shmem:208kB writeback_tmp:0kB unstable:0kB all_unreclaimable? no
Node 0 DMA free:6440kB min:48kB low:60kB high:72kB active_anon:0kB
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB
writepending:0kB present:15992kB managed:15908kB mlocked:0kB
kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB
free_cma:0kB
lowmem_reserve[]: 0 1607 1607 1607
Node 0 DMA32 free:1844kB min:5104kB low:6748kB high:8392kB
active_anon:14056kB inactive_anon:176kB active_file:12776kB
inactive_file:11516kB unevictable:0kB writepending:5896kB
present:2080760kB managed:1650852kB mlocked:0kB kernel_stack:2976kB
pagetables:1452kB bounce:0kB free_pcp:988kB local_pcp:272kB
free_cma:0kB
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 0*4kB 1*8kB (U) 0*16kB 1*32kB (U) 0*64kB 0*128kB 1*256kB
(U) 0*512kB 0*1024kB 1*2048kB (M) 1*4096kB (M) = 6440kB
Node 0 DMA32: 43*4kB (UME) 8*8kB (UME) 4*16kB (ME) 0*32kB 3*64kB (UME)
1*128kB (E) 3*256kB (UE) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB =
1900kB
Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
6123 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
524188 pages RAM
0 pages HighMem/MovableOnly
107498 pages reserved
SLUB: Unable to allocate memory on node -1, gfp=0x1080020(GFP_ATOMIC)
  cache: kmalloc-128, object size: 128, buffer size: 192, default
order: 0, min order: 0
  node 0: slabs: 374152, objs: 7857192, free: 0
usbtouchscreen 1-1:8.0: usbtouch_irq - usb_submit_urb failed with result: -12
INFO: rcu_sched self-detected stall on CPU
0-...: (1 GPs behind) idle=b32/140000000000002/0 softirq=5716/5717 fqs=0
(t=71918 jiffies g=2055 c=2054 q=23)
rcu_sched kthread starved for 71918 jiffies! g2055 c2054 f0x0
RCU_GP_WAIT_FQS(3) ->state=0x1
rcu_sched       S18936     8      2 0x00000000
Call Trace:
 context_switch kernel/sched/core.c:2771
 __schedule+0x6fa/0x1780 kernel/sched/core.c:3332
 schedule+0x106/0x450 kernel/sched/core.c:3391
 schedule_timeout+0x1d8/0x440 kernel/time/timer.c:1743
 rcu_gp_kthread+0x1edd/0x47e0 kernel/rcu/tree.c:2242
INFO: rcu_sched detected stalls on CPUs/tasks:
0-...: (1 GPs behind) idle=b32/140000000000002/0 softirq=5716/5717 fqs=0

(detected by 1, t=71918 jiffies, g=2055, c=2054, q=23)
Sending NMI from CPU 1 to CPUs 0:
 kthread+0x324/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
NMI backtrace for cpu 0
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.13.0+ #93
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
task: ffff88006bdc1a00 task.stack: ffff88006bde8000
RIP: 0010:down_trylock+0xaf/0x1a0 kernel/locking/semaphore.c:136
RSP: 0018:ffff88006c8057b0 EFLAGS: 00000802
RAX: ffff88006c805818 RBX: 1ffff1000d900af7 RCX: dffffc0000000000
RDX: 1ffff1000d900afb RSI: 0000000000000000 RDI: ffffffff870b7780
RBP: ffff88006c805900 R08: fffffbfff0fe33a3 R09: ffffffff87f19d15
R10: 0000000000000001 R11: fffffbfff0fe33a2 R12: dffffc0000000000
R13: ffff88006c8058d8 R14: ffffffff870b7780 R15: 0000000000000064
FS:  0000000000000000(0000) GS:ffff88006c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006e30a0 CR3: 000000006b983000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 __down_trylock_console_sem.isra.20+0xd8/0x170 kernel/printk/printk.c:228
 console_trylock kernel/printk/printk.c:2077
 vprintk_emit+0x543/0x5d0 kernel/printk/printk.c:1768
 vprintk_default+0x2d/0x40 kernel/printk/printk.c:1808
 vprintk_func+0x5c/0xd0 kernel/printk/printk_safe.c:382
 printk+0xcd/0xfe kernel/printk/printk.c:1841
 printk_stack_address arch/x86/kernel/dumpstack.c:50
 show_trace_log_lvl+0x26c/0x340 arch/x86/kernel/dumpstack.c:142
 show_stack+0x34/0x50 arch/x86/kernel/dumpstack.c:176
 sched_show_task+0x521/0x650 kernel/sched/core.c:5138
 rcu_check_gp_kthread_starvation+0x2fc/0x353 kernel/rcu/tree.c:1368
 print_cpu_stall+0x3ad/0x6d0 kernel/rcu/tree.c:1534
 check_cpu_stall.isra.72+0x707/0xe90 kernel/rcu/tree.c:1604
 __rcu_pending kernel/rcu/tree.c:3457
 rcu_pending kernel/rcu/tree.c:3519
 rcu_check_callbacks+0x241/0xa50 kernel/rcu/tree.c:2861
 update_process_times+0x35/0x70 kernel/time/timer.c:1590
 tick_sched_handle+0xf5/0x160 kernel/time/tick-sched.c:161
 tick_sched_timer+0x47/0x120 kernel/time/tick-sched.c:1190
 __run_hrtimer kernel/time/hrtimer.c:1213
 __hrtimer_run_queues+0x3f4/0x970 kernel/time/hrtimer.c:1277
 hrtimer_interrupt+0x22a/0x720 kernel/time/hrtimer.c:1311
 local_apic_timer_interrupt+0x74/0xe0 arch/x86/kernel/apic/apic.c:1019
 smp_apic_timer_interrupt+0x76/0xa0 arch/x86/kernel/apic/apic.c:1043
 apic_timer_interrupt+0x89/0x90
RIP: 0010:arch_local_irq_restore ./arch/x86/include/asm/paravirt.h:814
RIP: 0010:__raw_spin_unlock_irqrestore ./include/linux/spinlock_api_smp.h:160
RIP: 0010:_raw_spin_unlock_irqrestore+0xf5/0x160 kernel/locking/spinlock.c:191
RSP: 0018:ffff88006c806c40 EFLAGS: 00000a06 ORIG_RAX: ffffffffffffff10
RAX: 1ffff1000d900d95 RBX: 1ffff1000d900d89 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 0000000000000a06 RDI: 0000000000000a06
RBP: ffff88006c806d48 R08: fffffbfff0fe326e R09: ffffffff87f1936a
R10: ffff88006c806420 R11: fffffbfff0fe326d R12: 1ffff1000d900d9d
R13: 1ffff1000d900d8d R14: ffff88006796c200 R15: ffff8800679e5488
 spin_unlock_irqrestore ./include/linux/spinlock.h:354
 dummy_timer+0x1aa8/0x38c0 drivers/usb/gadget/udc/dummy_hcd.c:1938
 call_timer_fn+0xba/0x390 kernel/time/timer.c:1281
 expire_timers kernel/time/timer.c:1320
 __run_timers+0x9d0/0xda0 kernel/time/timer.c:1620
 run_timer_softirq+0x51/0xb0 kernel/time/timer.c:1646
 __do_softirq+0x258/0x7ac kernel/softirq.c:284
 invoke_softirq kernel/softirq.c:364
 irq_exit+0x14e/0x180 kernel/softirq.c:405
 exiting_irq ./arch/x86/include/asm/apic.h:638
 smp_apic_timer_interrupt+0x7b/0xa0 arch/x86/kernel/apic/apic.c:1044
 apic_timer_interrupt+0x89/0x90
RIP: 0
Lost 243 message(s)!
rcu_sched kthread starved for 71918 jiffies! g2055 c2054 f0x0
RCU_GP_WAIT_FQS(3) ->state=0x0
NMI backtrace for cpu 0
rcu_sched       R
CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.13.0+ #93
  running task
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
18936     8      2 0x00000000
 __dump_stack lib/dump_stack.c:16
 dump_stack+0x192/0x22c lib/dump_stack.c:52
Call Trace:
 context_switch kernel/sched/core.c:2771
 __schedule+0x6fa/0x1780 kernel/sched/core.c:3332
 nmi_cpu_backtrace+0x1f5/0x220 lib/nmi_backtrace.c:102
 nmi_trigger_cpumask_backtrace+0x108/0x160 lib/nmi_backtrace.c:61
 schedule+0x106/0x450 kernel/sched/core.c:3391
 arch_trigger_cpumask_backtrace+0x19/0x20 arch/x86/kernel/apic/hw_nmi.c:37
 trigger_single_cpu_backtrace ./include/linux/nmi.h:123
 rcu_dump_cpu_stacks+0x272/0x306 kernel/rcu/tree.c:1390
 schedule_timeout+0x1d8/0x440 kernel/time/timer.c:1743
 print_cpu_stall+0x3b5/0x6d0 kernel/rcu/tree.c:1536
 rcu_gp_kthread+0x1edd/0x47e0 kernel/rcu/tree.c:2242
 check_cpu_stall.isra.72+0x707/0xe90 kernel/rcu/tree.c:1604
 __rcu_pending kernel/rcu/tree.c:3457
 rcu_pending kernel/rcu/tree.c:3519
 rcu_check_callbacks+0x241/0xa50 kernel/rcu/tree.c:2861
 update_process_times+0x35/0x70 kernel/time/timer.c:1590
 tick_sched_handle+0xf5/0x160 kernel/time/tick-sched.c:161
 tick_sched_timer+0x47/0x120 kernel/time/tick-sched.c:1190
 __run_hrtimer kernel/time/hrtimer.c:1213
 __hrtimer_run_queues+0x3f4/0x970 kernel/time/hrtimer.c:1277
 hrtimer_interrupt+0x22a/0x720 kernel/time/hrtimer.c:1311
 local_apic_timer_interrupt+0x74/0xe0 arch/x86/kernel/apic/apic.c:1019
 smp_apic_timer_interrupt+0x76/0xa0 arch/x86/kernel/apic/apic.c:1043
 apic_timer_interrupt+0x89/0x90
RIP: 0010:arch_local_irq_restore ./arch/x86/include/asm/paravirt.h:814
RIP: 0010:__raw_spin_unlock_irqrestore ./include/linux/spinlock_api_smp.h:160
RIP: 0010:_raw_spin_unlock_irqrestore+0xf5/0x160 kernel/locking/spinlock.c:191
RSP: 0018:ffff88006c806c40 EFLAGS: 00000a06
 ORIG_RAX: ffffffffffffff10
RAX: 1ffff1000d900d95 RBX: 1ffff1000d900d89 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: 0000000000000a06 RDI: 0000000000000a06
RBP: ffff88006c806d48 R08: fffffbfff0fe326e R09: ffffffff87f1936a
R10: ffff88006c806420 R11: fffffbfff0fe326d R12: 1ffff1000d900d9d
R13: 1ffff1000d900d8d R14: ffff88006796c200 R15: ffff8800679e5488
 kthread+0x324/0x3f0 kernel/kthread.c:231
 spin_unlock_irqrestore ./include/linux/spinlock.h:354
 dummy_timer+0x1aa8/0x38c0 drivers/usb/gadget/udc/dummy_hcd.c:1938
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
 call_timer_fn+0xba/0x390 kernel/time/timer.c:1281
 expire_timers kernel/time/timer.c:1320
 __run_timers+0x9d0/0xda0 kernel/time/timer.c:1620
 run_timer_softirq+0x51/0xb0 kernel/time/timer.c:1646
 __do_softirq+0x258/0x7ac kernel/softirq.c:284
 invoke_softirq kernel/softirq.c:364
 irq_exit+0x14e/0x180 kernel/softirq.c:405
 exiting_irq ./arch/x86/include/asm/apic.h:638
 smp_apic_timer_interrupt+0x7b/0xa0 arch/x86/kernel/apic/apic.c:1044
 apic_timer_interrupt+0x89/0x90
RIP: 0010:arch_local_irq_restore ./arch/x86/include/asm/paravirt.h:814
RIP: 0010:console_unlock+0x814/0xcd0 kernel/printk/printk.c:2247
RSP: 0018:ffff88006bdedd30 EFLAGS: 00000a06 ORIG_RAX: ffffffffffffff10
RAX: 1ffff1000d7bdbe8 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1ffff1000d7bdbe0 RSI: ffffffff87f007c0 RDI: 0000000000000a06
RBP: ffff88006bdee0a8 R08: fffffbfff0fe0102 R09: fffffbfff0fe0102
R10: 0000000000000009 R11: fffffbfff0fe0101 R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: ffffffff82d15610
 </IRQ>
 vprintk_emit+0x567/0x5d0 kernel/printk/printk.c:1769
 vprintk_default+0x2d/0x40 kernel/printk/printk.c:1808
 vprintk_func+0x5c/0xd0 kernel/printk/printk_safe.c:382
 printk+0xcd/0xfe kernel/printk/printk.c:1841
 evbug_connect+0x1de/0x260 drivers/input/evbug.c:69
 input_attach_handler+0x59a/0x740 drivers/input/input.c:1002
 input_register_device+0xcb8/0xf90 drivers/input/input.c:2159
 usbtouch_probe+0x1372/0x1fe0 drivers/input/touchscreen/usbtouchscreen.c:1690
 usb_probe_interface+0x351/0x8d0 drivers/usb/core/driver.c:361
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_set_configuration+0x1064/0x1890 drivers/usb/core/message.c:1932
 generic_probe+0x73/0xe0 drivers/usb/core/generic.c:174
 usb_probe_device+0xaf/0xe0 drivers/usb/core/driver.c:266
 really_probe drivers/base/dd.c:385
 driver_probe_device+0x610/0xa00 drivers/base/dd.c:529
 __device_attach_driver+0x230/0x290 drivers/base/dd.c:625
 bus_for_each_drv+0x15e/0x210 drivers/base/bus.c:463
 __device_attach+0x269/0x3c0 drivers/base/dd.c:682
 device_initial_probe+0x1f/0x30 drivers/base/dd.c:729
 bus_probe_device+0x1da/0x280 drivers/base/bus.c:523
 device_add+0xcf9/0x1640 drivers/base/core.c:1703
 usb_new_device+0x7b8/0x1020 drivers/usb/core/hub.c:2457
 hub_port_connect drivers/usb/core/hub.c:4890
 hub_port_connect_change drivers/usb/core/hub.c:4996
 port_event drivers/usb/core/hub.c:5102
 hub_event+0x23c8/0x37c0 drivers/usb/core/hub.c:5182
 process_one_work+0x9fb/0x1570 kernel/workqueue.c:2097
 worker_thread+0x1e4/0x1350 kernel/workqueue.c:2231
 kthread+0x324/0x3f0 kernel/kthread.c:231
 ret_from_fork+0x25/0x30 arch/x86/entry/entry_64.S:425
dummy_hcd dummy_hcd.0: timer fired with no URBs pending?
gadgetfs: disconnected
usb 1-1: USB disconnect, device number 2
evbug: Disconnected device: input8
