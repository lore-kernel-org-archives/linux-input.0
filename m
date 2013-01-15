From: Andre Guedes <andre.guedes@openbossa.org>
Subject: Re: [RFC v2 0/4] uhid LED input events handling
Date: Tue, 15 Jan 2013 19:04:50 -0300
Message-ID: <CACJA=fXx=c4MEmXBJyitr1f5Xi5tbVovAtkNBjhvwDyUP2ARxA@mail.gmail.com>
References: <1354388841-23854-1-git-send-email-andre.guedes@openbossa.org>
	<CACJA=fUYX0Wehd--Ay0bwSS+9visC5By=SCWaoVkvKjVsJySKQ@mail.gmail.com>
	<CANq1E4S_TzeCZ-djPxBcOYHFEoBxUdQpruTe52mtTq-nkCdc2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:54855 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab3AOWEw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2013 17:04:52 -0500
Received: by mail-bk0-f47.google.com with SMTP id j4so357698bkw.6
        for <linux-input@vger.kernel.org>; Tue, 15 Jan 2013 14:04:50 -0800 (PST)
In-Reply-To: <CANq1E4S_TzeCZ-djPxBcOYHFEoBxUdQpruTe52mtTq-nkCdc2Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi David,

On Thu, Dec 20, 2012 at 4:43 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Andre
>
> On Mon, Dec 17, 2012 at 2:28 PM, Andre Guedes
> <andre.guedes@openbossa.org> wrote:
>> Ping.
>>
>> On Sat, Dec 1, 2012 at 4:07 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
>>> Hi all,
>>>
>>> This patchset implements the support for handling LED input events in uhid
>>> driver.
>>>
>>> As requested in the previous RFC, it was introduced a new helper in hid-input.c
>>> to carry out a generic LED input events handling (hidinput_led_output_report).
>>> The helper is used by uhid driver.
>>>
>>> The helper can also be used in i2c-hid driver since it does a very simply
>>> handling of LED events too. I have no i2c device to test the i2c-hid patch,
>>> so it requires some testing before applying it.
>>>
>>> As long as the helper relies on device's .hid_output_raw_report() and
>>> hid-logitech-dj driver doesn't properly implement this callback, the helper is
>>> not used in hid-logitech-dj driver.
>>>
>>> Also, this helper is not used in usbhid driver as long as it does a more
>>> sophisticated handling than what hidinput_led_output_report helper does. For
>>> further information about usbhid LEDs handling see comments in the patchset [1].
>
> I actually don't like the idea to call hid_output_raw_report() from
> atomic-contexts. Using a work-queue would allow to use your callback
> from usbhid and hidp. Furthermore, you wouldn't need the GFP_ATOMIC
> patch for uhid.

I agree with you about calling hid_output_raw_report from atomic
sections. I'll re-write hidinput_led_output_report and use a work.

> I am actually ok with all the uhid patches, but Jiri needs to ack the
> hid-core patches. Maybe he is ok with it, but I'd like to see all
> ll_drivers using this callback. Because the current solution doesn't
> seem any better than just fixing uhid to use it's own implementation.
> Also please elaborate why hidp and usbhid cannot use this callback.

Usbhid uses a more sophisticated approach to handle LED input events.
When a LED input event occurs it only sets the "field" and schedule a
work to carry out sending the report to the device. This way, it is
more likely to gather all LED changes into a single URB. This prevents
a race condition when trying to suspend a laptop with an attached USB
keyboard with both NumLock and CapsLock LEDs on. The race condition is
explained in details in [1, 2, 3].

In hidp, hidinput_led_output_report runs in atomic section, but hidp
.hid_output_raw_report() callback may sleep.

Anyway, with the workqueue approach, I believe we'll be able to use
the helper in all ll_drivers.

As you are ok with uhid changes, I was wondering if we could take an
incremental approach here. First we would simply fix the uhid driver
by handling LED events the same way others ll_drivers do. This way, we
would get uhid sending output reports to userspace and HID over GATT
working fine. Meanwhile, I'll keep working on this refactoring and
testing the ll_drivers. As soon as it is well-tested, I send a new
patchset.

Are you fine with this approach? If you agree, I can send the uhid
patch right away.

Best regards,

Andre

[1] - http://marc.info/?l=linux-usb&m=132013970108623&w=2
[2] - http://marc.info/?l=linux-usb&m=132013966708616&w=2
[3] - http://marc.info/?l=linux-usb&m=132013968208618&w=2
