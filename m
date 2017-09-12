From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Tue, 12 Sep 2017 17:48:51 +0200
Message-ID: <CAAeHK+yDjw3sh=7nCEZTRqHPWUwxKNfQ1-WVq5=K2PWK5E2FFw@mail.gmail.com>
References: <CAAeHK+y-gycNCJv3XEZ4hwv_BndB590UWVqCYWd-Y8URDbH+vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org>
 <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com> <CAKdAkRQFmKpKWqh4JenNZcs22D4QZbyo+Rhh9Y5jOQk=z0uKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRQFmKpKWqh4JenNZcs22D4QZbyo+Rhh9Y5jOQk=z0uKCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 11, 2017 at 8:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Sep 11, 2017 at 8:15 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
>> On Mon, Sep 11, 2017 at 3:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> On Mon, 11 Sep 2017, Andrey Konovalov wrote:
>>>
>>>> Hi!
>>>>
>>>> I've been getting stall reports like this one while fuzzing the USB
>>>> stack with gadgetfs. I'm wondering whether this is a bug in gadgetfs
>>>> or is this report induced by the changes I've made to the USB core
>>>> code. I didn't touch gadgetfs code though (except for adding a few
>>>> printk's).
>>>>
>>>> I'm on commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432
>>>
>>> It's possible that this was caused by commit f16443a034c7 ("USB:
>>> gadgetfs, dummy-hcd, net2280: fix locking for callbacks").  I've been
>>> meaning to repair the commit but haven't done it yet.
>>>
>>> Can you test with that commit reverted?  You may end up seeing other
>>> problems instead -- the ones that commit was intended to solve -- but
>>> perhaps the stalls won't occur.
>>
>> So I've reverted both: the changes I made to USB core and the commit
>> you mentioned, still saw the stalls.
>>
>> I've manged to find a way to reproduce this and now I'm not sure the
>> problem is actually in gadgetfs, it might be the usbtouchscreen
>> driver.
>>
>> The crash log is below.
>>
>> Thanks!
>>
>> gadgetfs: bound to dummy_udc driver
>> usb 1-1: new full-speed USB device number 2 using dummy_hcd
>> gadgetfs: connected
>> gadgetfs: disconnected
>> gadgetfs: connected
>> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has an
>> invalid bInterval 0, changing to 10
>> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has invalid
>> maxpacket 839, setting to 64
>> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x7 has invalid
>> maxpacket 1839, setting to 64
>> usb 1-1: config 8 interface 0 has no altsetting 0
>> usb 1-1: New USB device found, idVendor=0403, idProduct=f9e9
>> usb 1-1: New USB device strings: Mfr=4, Product=8, SerialNumber=255
>> usb 1-1: Product: a
>> usb 1-1: Manufacturer: a
>> usb 1-1: SerialNumber: a
>> gadgetfs: configuration #8
>> input: a a as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:8.0/input/input8
>> evbug: Connected device: input8 (a a at usb-dummy_hcd.0-1/input0)
>> kworker/0:0: page allocation failure: order:0,
>> mode:0x1280020(GFP_ATOMIC|__GFP_NOTRACK), nodemask=(null)
>> kworker/0:0 cpuset=/ mems_allowed=0
>
> It seems you are running out of memory.
>
>> Swap cache stats: add 0, delete 0, find 0/0
>> Free swap  = 0kB
>> Total swap = 0kB
>
> And no swap. I think you need to give the box a bit more memory (or
> there might be a leak somewhere).

Increasing the amount of memory doesn't help. It looks like
usbtouch_irq() gets called in an infinite loop, and calls
usb_submit_urb on each iteration, until the kernel runs out of memory.

(gdb) bt
#0  unwind_next_frame (state=0xffff8801f6806120) at
arch/x86/kernel/unwind_frame.c:277
#1  0xffffffff81109e33 in unwind_next_frame (state=0xffff8801f515bd98)
at arch/x86/kernel/unwind_frame.c:269
#2  0xffffffff8108fa13 in __save_stack_trace
(trace=0xffff8801f68061b8, task=0xffff8801f515b400, regs=0x0
<irq_stack_union>, nosched=false) at arch/x86/kernel/stacktrace.c:44
#3  0xffffffff8108fa8b in save_stack_trace (trace=<optimized out>) at
arch/x86/kernel/stacktrace.c:59
#4  0xffffffff81723873 in save_stack (flags=17301536) at mm/kasan/kasan.c:447
#5  0xffffffff81723b3d in set_track (flags=<optimized out>,
track=<optimized out>) at mm/kasan/kasan.c:459
#6  kasan_kmalloc (cache=0xffff8801f515bd98, object=<optimized out>,
size=<optimized out>, flags=17301536) at mm/kasan/kasan.c:551
#7  0xffffffff81724102 in kasan_slab_alloc (cache=<optimized out>,
object=<optimized out>, flags=<optimized out>) at mm/kasan/kasan.c:489
#8  0xffffffff8171f836 in slab_post_alloc_hook (p=<optimized out>,
size=<optimized out>, flags=<optimized out>, s=<optimized out>) at
mm/slab.h:440
#9  slab_alloc_node (addr=<optimized out>, node=<optimized out>,
gfpflags=<optimized out>, s=<optimized out>) at mm/slub.c:2712
#10 slab_alloc (addr=<optimized out>, gfpflags=<optimized out>,
s=<optimized out>) at mm/slub.c:2720
#11 kmem_cache_alloc_trace (s=0xffff8801f6401640, gfpflags=17301536,
size=<optimized out>) at mm/slub.c:2737
#12 0xffffffff83dc4ce3 in kmalloc (flags=<optimized out>,
size=<optimized out>) at ./include/linux/slab.h:493
#13 dummy_urb_enqueue (hcd=0xffff8801f0e5d200, urb=0xffff8801eac10d00,
mem_flags=17301536) at drivers/usb/gadget/udc/dummy_hcd.c:1220
#14 0xffffffff839bf3d3 in usb_hcd_submit_urb (urb=0xffff8801eac10d00,
mem_flags=17301536) at drivers/usb/core/hcd.c:1664
#15 0xffffffff839c4327 in usb_submit_urb (urb=0xffff8801eac10d00,
mem_flags=<optimized out>) at drivers/usb/core/urb.c:542
#16 0xffffffff840bda26 in usbtouch_irq (urb=0xffff8801eac10d00) at
drivers/input/touchscreen/usbtouchscreen.c:1441
#17 0xffffffff839b90c1 in __usb_hcd_giveback_urb
(urb=0xffff8801eac10d00) at drivers/usb/core/hcd.c:1779
#18 0xffffffff839b971f in usb_hcd_giveback_urb
(hcd=0xffff8801f0e5d200, urb=0xffff8801eac10d00, status=<optimized
out>) at drivers/usb/core/hcd.c:1845
#19 0xffffffff83dc755a in dummy_timer (_dum_hcd=<optimized out>) at
drivers/usb/gadget/udc/dummy_hcd.c:1924
#20 0xffffffff813245ba in call_timer_fn (timer=<optimized out>,
fn=<optimized out>, data=<optimized out>) at kernel/time/timer.c:1281
#21 0xffffffff81325550 in expire_timers (head=<optimized out>,
base=<optimized out>) at kernel/time/timer.c:1320
#22 __run_timers (base=0xffff8801f6819d80) at kernel/time/timer.c:1620
#23 0xffffffff81325971 in run_timer_softirq (h=<optimized out>) at
kernel/time/timer.c:1646
#24 0xffffffff85fe92f8 in __do_softirq () at kernel/softirq.c:284
#25 0xffffffff8115a8ae in invoke_softirq () at kernel/softirq.c:364
#26 irq_exit () at kernel/softirq.c:405
#27 0xffffffff85fe812b in exiting_irq () at ./arch/x86/include/asm/apic.h:638
#28 smp_apic_timer_interrupt (regs=<optimized out>) at
arch/x86/kernel/apic/apic.c:1044
#29 0xffffffff85fe52d9 in apic_timer_interrupt () at
arch/x86/entry/entry_64.S:482
#30 0xffff8801f518e658 in ?? ()
#31 0x0000000000000000 in ?? ()


>
> Thanks.
>
> --
> Dmitry
