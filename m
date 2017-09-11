From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: usb/gadget: stalls in dummy_timer
Date: Mon, 11 Sep 2017 11:54:07 -0700
Message-ID: <CAKdAkRQFmKpKWqh4JenNZcs22D4QZbyo+Rhh9Y5jOQk=z0uKCw@mail.gmail.com>
References: <CAAeHK+y-gycNCJv3XEZ4hwv_BndB590UWVqCYWd-Y8URDbH+vg@mail.gmail.com>
 <Pine.LNX.4.44L0.1709110920020.27275-100000@netrider.rowland.org> <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36880 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdIKSyJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 14:54:09 -0400
In-Reply-To: <CAAeHK+yMO9v8SeSkqeoDy=FV8gZ9672iDEw3OadHh0cdg-9T_g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Henrik Rydberg <rydberg@bitmath.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <johan@kernel.org>, Peter Chen <peter.chen@nxp.com>, Yuyang Du <yuyang.du@intel.com>, USB list <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>

On Mon, Sep 11, 2017 at 8:15 AM, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Mon, Sep 11, 2017 at 3:25 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Mon, 11 Sep 2017, Andrey Konovalov wrote:
>>
>>> Hi!
>>>
>>> I've been getting stall reports like this one while fuzzing the USB
>>> stack with gadgetfs. I'm wondering whether this is a bug in gadgetfs
>>> or is this report induced by the changes I've made to the USB core
>>> code. I didn't touch gadgetfs code though (except for adding a few
>>> printk's).
>>>
>>> I'm on commit 81a84ad3cb5711cec79f4dd53a4ce026b092c432
>>
>> It's possible that this was caused by commit f16443a034c7 ("USB:
>> gadgetfs, dummy-hcd, net2280: fix locking for callbacks").  I've been
>> meaning to repair the commit but haven't done it yet.
>>
>> Can you test with that commit reverted?  You may end up seeing other
>> problems instead -- the ones that commit was intended to solve -- but
>> perhaps the stalls won't occur.
>
> So I've reverted both: the changes I made to USB core and the commit
> you mentioned, still saw the stalls.
>
> I've manged to find a way to reproduce this and now I'm not sure the
> problem is actually in gadgetfs, it might be the usbtouchscreen
> driver.
>
> The crash log is below.
>
> Thanks!
>
> gadgetfs: bound to dummy_udc driver
> usb 1-1: new full-speed USB device number 2 using dummy_hcd
> gadgetfs: connected
> gadgetfs: disconnected
> gadgetfs: connected
> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has an
> invalid bInterval 0, changing to 10
> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x8F has invalid
> maxpacket 839, setting to 64
> usb 1-1: config 8 interface 0 altsetting 9 endpoint 0x7 has invalid
> maxpacket 1839, setting to 64
> usb 1-1: config 8 interface 0 has no altsetting 0
> usb 1-1: New USB device found, idVendor=0403, idProduct=f9e9
> usb 1-1: New USB device strings: Mfr=4, Product=8, SerialNumber=255
> usb 1-1: Product: a
> usb 1-1: Manufacturer: a
> usb 1-1: SerialNumber: a
> gadgetfs: configuration #8
> input: a a as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:8.0/input/input8
> evbug: Connected device: input8 (a a at usb-dummy_hcd.0-1/input0)
> kworker/0:0: page allocation failure: order:0,
> mode:0x1280020(GFP_ATOMIC|__GFP_NOTRACK), nodemask=(null)
> kworker/0:0 cpuset=/ mems_allowed=0

It seems you are running out of memory.

> Swap cache stats: add 0, delete 0, find 0/0
> Free swap  = 0kB
> Total swap = 0kB

And no swap. I think you need to give the box a bit more memory (or
there might be a leak somewhere).

Thanks.

-- 
Dmitry
