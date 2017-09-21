From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: usb/hid: slab-out-of-bounds read in usbhid_parse
Date: Thu, 21 Sep 2017 10:42:12 +0900
Message-ID: <CAL6iAa+1MYuu6rvuUY2f7tH+SeBu-0PPeRQN9fJXW6uzj_f2+g@mail.gmail.com>
References: <CAL6iAa+Pd83Z0zA-26cvEbMxmH7r0QbUzi9XZowoEiZ8emZv+Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1709201149420.1563-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:47622 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdIUBmN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 21:42:13 -0400
In-Reply-To: <Pine.LNX.4.44L0.1709201149420.1563-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrey Konovalov <andreyknvl@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, USB list <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>

Hi Alan

2017-09-21 0:50 GMT+09:00 Alan Stern <stern@rowland.harvard.edu>:
> On Wed, 20 Sep 2017, Kim Jaejoong wrote:
>
>> To. usb & input guys.
>>
>> While dig this report, i was wondering about bNumDescriptors in HID descriptor.
>> HID document from usb.org said, 'this number must be at least one (1)
>> as a Report descriptor will always be present.'
>>
>> There is no mention of the order of class descriptors. Suppose you
>> have a HID device with a report descriptor and a physical descriptor.
>>
>> If you have the following hid descriptor in this case,
>> HID descriptor
>>    bLength: 12
>>    bDescriptor Type: HID
>>    .. skip
>>    bNumDescriptors: 2
>>    bDescriptorType: physical
>>    bDescriptorLength: any
>>    bDescriptorType: Report
>>    bDescriptorLength: any
>>
>> If the order of the report descriptor is the second as above,
>> usbhid_parse () will fail because my patch is only check the first
>> bDescriptor Type.
>> But If the order of the report descriptor is always first, there is no
>> problem. How do you think this?
>
> The descriptors can appear in any order.  You should not assume that
> the report descriptor will always come first.

Thanks for clarifying. I will resend patch with modification.

Jaejoong

>
> Alan Stern
>
