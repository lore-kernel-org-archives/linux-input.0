From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 13:11:30 -0800
Message-ID: <CALCETrVtA9rCDqAetaFj=tCo=ebWW43mA4f8n6fMZdCnE9TvgA@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <alpine.LNX.2.00.1411022134120.19451@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:61962 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbaKBVLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 16:11:52 -0500
Received: by mail-la0-f54.google.com with SMTP id s18so3212537lam.27
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2014 13:11:50 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1411022134120.19451@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, linux-input@vger.kernel.org

On Sun, Nov 2, 2014 at 12:42 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Sun, 2 Nov 2014, Andy Lutomirski wrote:
>
>> I want to get U2F (universal second factor, sometimes called "security
>> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
>> that speak a custom protocol.  The intent is that user code will speak
>> to then using something like HIDAPI.
>>
>> The trick is that, for HIDAPI to work, something needs to recognize
>> these devices and get udev to set appropriate device permissions.
>
> Just to make sure we are on the same page -- this is really only about
> setting proper device node permissions and nothing else, right?

Yes.

>
>> My question is: how should this be done?  The official way to
>> enumerate U2F devices is to look for a HID usage page 0xf1d0
>> containing usage 0x1.
>>
>> Options include:
>>
>>  - A builtin udev helper that reads the sysfs report_descriptor for
>> hid or hidraw devices and sets attributes accordingly (either
>> ID_SECURITY_TOKEN or something more general).
>
> Hmmm ... please keep in mind that report_descriptor is actually in
> debugfs, so it's a bit questionable whether you can rely on it being
> present on well-defined location on all systems.
>

Huh?  I have /sys/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:1050:0120.0013/report_descriptor
on my system.

> You can get it from different other places though, such as libusb (but
> then you are limited only to USB HID devices ... which might be enough
> in your particular case).

I have no idea whether there will ever be a bluetooth U2F device.

>
>> - A udev helper that does this and doesn't live in the systemd tree.
>> I don't love this option -- I'd prefer for this to be as plug-and-play
>> as possible.
>
> Agreed.
>
>> - HID core code in the kernel to add
>> HID_USAGES=f1d00001:lots:of:other:things to the uevent (or udev code
>> to do the same).  This might end up producing a rather long string or
>> some devices.
>
> We have been thinking about this quite a lot in the past, and decided to
> postpone this until there is a very good reason for it to happen.

I'm not sure that U2F counts as a very good reason.

>
>>  - An actual kernel driver for U2F devices using the hid group
>> mechanism for enumeration.  This seems overcomplicated.
>
> Hmmm ... why do you think so? I believe it actually should be really
> super-trivial.

The HID group part is trivial, but what interface would the driver
expose?  I don't think that a udev rule for hidraw matching the
modalias makes any sense, and, if it were a real driver, what
interface would it expose?  Most cross-platform userspace code for U2F
is likely to use HIDAPI.

Admittedly, a U2F driver in the kernel would be slightly nicer from a
multiplexing standpoint than hidraw.

--Andy
