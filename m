From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb/hid: slab-out-of-bounds read in usbhid_parse
Date: Wed, 20 Sep 2017 11:50:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1709201149420.1563-100000@iolanthe.rowland.org>
References: <CAL6iAa+Pd83Z0zA-26cvEbMxmH7r0QbUzi9XZowoEiZ8emZv+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL6iAa+Pd83Z0zA-26cvEbMxmH7r0QbUzi9XZowoEiZ8emZv+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Jaejoong <climbbb.kim@gmail.com>
Cc: Andrey Konovalov <andreyknvl@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-input@vger.kernel.org

On Wed, 20 Sep 2017, Kim Jaejoong wrote:

> To. usb & input guys.
> 
> While dig this report, i was wondering about bNumDescriptors in HID descriptor.
> HID document from usb.org said, 'this number must be at least one (1)
> as a Report descriptor will always be present.'
> 
> There is no mention of the order of class descriptors. Suppose you
> have a HID device with a report descriptor and a physical descriptor.
> 
> If you have the following hid descriptor in this case,
> HID descriptor
>    bLength: 12
>    bDescriptor Type: HID
>    .. skip
>    bNumDescriptors: 2
>    bDescriptorType: physical
>    bDescriptorLength: any
>    bDescriptorType: Report
>    bDescriptorLength: any
> 
> If the order of the report descriptor is the second as above,
> usbhid_parse () will fail because my patch is only check the first
> bDescriptor Type.
> But If the order of the report descriptor is always first, there is no
> problem. How do you think this?

The descriptors can appear in any order.  You should not assume that 
the report descriptor will always come first.

Alan Stern
