From: Andrey Konovalov <andreyknvl@google.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Thu, 14 Sep 2017 18:02:14 +0200
Message-ID: <CAAeHK+yCz++ShQW5qgVOxo7Cam4M7tAefHn+ZLySZeDiObJpYw@mail.gmail.com>
References: <CAAeHK+y-gycNCJv3XEZ4hwv_BndB590UWVqCYWd-Y8URDbH+vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org>
 <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com>
 <CAKdAkRQFmKpKWqh4JenNZcs22D4QZbyo+Rhh9Y5jOQk=z0uKCw@mail.gmail.com>
 <CAAeHK+yDjw3sh=7nCEZTRqHPWUwxKNfQ1-WVq5=K2PWK5E2FFw@mail.gmail.com>
 <20170912170637.GA37632@dtor-ws> <CAAeHK+yP_KDWZk6keGg2uP36Aua-1JaS-eMqQ1cWsdY=aeKTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAeHK+yP_KDWZk6keGg2uP36Aua-1JaS-eMqQ1cWsdY=aeKTzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 12, 2017 at 7:44 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Tue, Sep 12, 2017 at 7:06 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Tue, Sep 12, 2017 at 05:48:51PM +0200, Andrey Konovalov wrote:
>>> On Mon, Sep 11, 2017 at 8:54 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Mon, Sep 11, 2017 at 8:15 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
>>> >> On Mon, Sep 11, 2017 at 3:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> >>> On Mon, 11 Sep 2017, Andrey Konovalov wrote:
>>> >>>
>>> >>>> Hi!
>>> >>>>
>>> >>>> I've been getting stall reports like this one while fuzzing the USB
>>> >>>> stack with gadgetfs. I'm wondering whether this is a bug in gadgetfs
>>> >>>> or is this report induced by the changes I've made to the USB core
>>> >>>> code. I didn't touch gadgetfs code though (except for adding a few
>>> >>>> printk's).
>>> >>>>
>>> >>>> I'm on commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432
>>> >>>
>>> >>> It's possible that this was caused by commit f16443a034c7 ("USB:
>>> >>> gadgetfs, dummy-hcd, net2280: fix locking for callbacks").  I've been
>>> >>> meaning to repair the commit but haven't done it yet.
>>> >>>
>>> >>> Can you test with that commit reverted?  You may end up seeing other
>>> >>> problems instead -- the ones that commit was intended to solve -- but
>>> >>> perhaps the stalls won't occur.
>>> >>
>>> >> So I've reverted both: the changes I made to USB core and the commit
>>> >> you mentioned, still saw the stalls.
>>> >>
>>> >> I've manged to find a way to reproduce this and now I'm not sure the
>>> >> problem is actually in gadgetfs, it might be the usbtouchscreen
>>> >> driver.
>>> >>
>>> >> The crash log is below.
>>> >>
>>> >> Thanks!
>>> >>
>>> >> gadgetfs: bound to dummy_udc driver
>>> >> usb 1-1: new full-speed USB device number 2 using dummy_hcd
>>> >> gadgetfs: connected
>>> >> gadgetfs: disconnected
>>> >> gadgetfs: connected
>>> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has an
>>> >> invalid bInterval 0, changing to 10
>>> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has invalid
>>> >> maxpacket 839, setting to 64
>>> >> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x7 has invalid
>>> >> maxpacket 1839, setting to 64
>>> >> usb 1-1: config 8 interface 0 has no altsetting 0
>>> >> usb 1-1: New USB device found, idVendor=0403, idProduct=f9e9
>>> >> usb 1-1: New USB device strings: Mfr=4, Product=8, SerialNumber=255
>>> >> usb 1-1: Product: a
>>> >> usb 1-1: Manufacturer: a
>>> >> usb 1-1: SerialNumber: a
>>> >> gadgetfs: configuration #8
>>> >> input: a a as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:8.0/input/input8
>>> >> evbug: Connected device: input8 (a a at usb-dummy_hcd.0-1/input0)
>>> >> kworker/0:0: page allocation failure: order:0,
>>> >> mode:0x1280020(GFP_ATOMIC|__GFP_NOTRACK), nodemask=(null)
>>> >> kworker/0:0 cpuset=/ mems_allowed=0
>>> >
>>> > It seems you are running out of memory.
>>> >
>>> >> Swap cache stats: add 0, delete 0, find 0/0
>>> >> Free swap  = 0kB
>>> >> Total swap = 0kB
>>> >
>>> > And no swap. I think you need to give the box a bit more memory (or
>>> > there might be a leak somewhere).
>>>
>>> Increasing the amount of memory doesn't help. It looks like
>>> usbtouch_irq() gets called in an infinite loop, and calls
>>> usb_submit_urb on each iteration, until the kernel runs out of memory.
>>
>> Yes, that is exactly how USB interrupt-driven devices work. Their URB
>> completion routine handles the data and immediately resubmits URB to get
>> more data. The device/HCD will signal interrupt once more data is
>> available and the process starts over again. The only time we stop
>> resubmitting URBs if we get one of the following errors:
>>
>>         case -ETIME:
>>                 /* this urb is timing out */
>>                 dev_dbg(dev,
>>                         "%s - urb timed out - was the device unplugged?\n",
>>                         __func__);
>>                 return;
>>         case -ECONNRESET:
>>         case -ENOENT:
>>         case -ESHUTDOWN:
>>         case -EPIPE:
>>                 /* this urb is terminated, clean up */
>>                 dev_dbg(dev, "%s - urb shutting down with status: %d\n",
>>                         __func__, urb->status);
>>                 return;
>>
>> So I'd start looking into dummy_hcd and see why it does not discard
>> processed URBs fast enough in your setup.
>
> I now have a C reproducer (attached), which causes this behavior on
> upstream kernel built with attached .config on commit
> 81a84ad3cb5711cec79f4dd53a4ce026b092c432, so I'm not sure if the issue
> is with my particular setup.

Looked at this a little more.

dummy_timer() stucks in an infinite loop. It calls
usb_hcd_giveback_urb(), which in turn calls usbtouch_irq(), which
calls usb_submit_urb(), which calls dummy_urb_enqueue() and puts urb
back into dummy urb queue. dummy_timer() then does goto restart, finds
the urb and calls usb_hcd_giveback_urb() again. And this process goes
on again and again. It seems that something should either process the
urb and set urb->status or it should just expire.

>
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
