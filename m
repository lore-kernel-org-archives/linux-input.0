From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Mon, 3 Nov 2014 11:19:34 -0800
Message-ID: <CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:65095 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbaKCTT4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 14:19:56 -0500
Received: by mail-la0-f48.google.com with SMTP id gq15so9887180lab.7
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 11:19:54 -0800 (PST)
In-Reply-To: <CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Mon, Nov 3, 2014 at 11:03 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Sun, Nov 2, 2014 at 7:57 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> I want to get U2F (universal second factor, sometimes called "security
>> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
>> that speak a custom protocol.  The intent is that user code will speak
>> to then using something like HIDAPI.
>>
>> The trick is that, for HIDAPI to work, something needs to recognize
>> these devices and get udev to set appropriate device permissions.
>
> [snip]
>
>>  - An actual kernel driver for U2F devices using the hid group
>> mechanism for enumeration.  This seems overcomplicated.
>
> Imho, this is the way to go. Create a proper char-dev for U2F, create
> an API and make it work.
>
> We had this discussion earlier about vendor-extensions that should be
> writable via hidraw from user-space. This turned out to be really
> messy.. and was discussed for several weeks straight. hidraw just
> wasn't designed as unprivileged user-space API. For instance, what
> happens if a device provides U2F plus something else? Both will be on
> the same hidraw device.
> We could split hidraw per usage, but I don't see how that is superior
> to a proper U2F API. And once one usage can affect a device as a whole
> (like power-off), you're screwed.

Agreed, mostly.  My only real concern is that this could be annoying
for the userspace developers who will need to target Linux and HIDAPI
separately.  Admittedly the Linux support will be trivial.

I can give the driver a try.  It'll actually be simpler than the spec
makes it out, since a real kernel driver will have no need to
arbitrate with itself.

--Andy

>
> Just look at the libusb mess where some devices are handled in the
> kernel and some in user-space (eg., see Gnome cheese, media devices,
> ...). I don't think we should repeat that with HID.
>
> Thanks
> David



-- 
Andy Lutomirski
AMA Capital Management, LLC
