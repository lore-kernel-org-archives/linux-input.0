From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Mon, 3 Nov 2014 20:31:45 +0100
Message-ID: <CANq1E4Sa=D_hvSp2SqHy4cV-oxd-kchsNVivcF54cBv8DK7gOQ@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
	<CANq1E4QvuNHRq6Saca-KigTjmvyosqM6_JkqF-_OHqxLa=Zdow@mail.gmail.com>
	<CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36544 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbaKCTbp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 14:31:45 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so5946934iec.40
        for <linux-input@vger.kernel.org>; Mon, 03 Nov 2014 11:31:45 -0800 (PST)
In-Reply-To: <CALCETrVU5Kq0wYGXNQ1dsihy1LN1WUmAN4J9puyVPv=b_WNrLw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Mon, Nov 3, 2014 at 8:19 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Nov 3, 2014 at 11:03 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Hi
>>
>> On Sun, Nov 2, 2014 at 7:57 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> I want to get U2F (universal second factor, sometimes called "security
>>> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
>>> that speak a custom protocol.  The intent is that user code will speak
>>> to then using something like HIDAPI.
>>>
>>> The trick is that, for HIDAPI to work, something needs to recognize
>>> these devices and get udev to set appropriate device permissions.
>>
>> [snip]
>>
>>>  - An actual kernel driver for U2F devices using the hid group
>>> mechanism for enumeration.  This seems overcomplicated.
>>
>> Imho, this is the way to go. Create a proper char-dev for U2F, create
>> an API and make it work.
>>
>> We had this discussion earlier about vendor-extensions that should be
>> writable via hidraw from user-space. This turned out to be really
>> messy.. and was discussed for several weeks straight. hidraw just
>> wasn't designed as unprivileged user-space API. For instance, what
>> happens if a device provides U2F plus something else? Both will be on
>> the same hidraw device.
>> We could split hidraw per usage, but I don't see how that is superior
>> to a proper U2F API. And once one usage can affect a device as a whole
>> (like power-off), you're screwed.
>
> Agreed, mostly.  My only real concern is that this could be annoying
> for the userspace developers who will need to target Linux and HIDAPI
> separately.  Admittedly the Linux support will be trivial.

I see. I'll not stop you from using hidraw, I'd just not recommend it.
Especially for security stuff I dislike exposing the whole HID device
writable. But yeah, I guess you got my point.

> I can give the driver a try.  It'll actually be simpler than the spec
> makes it out, since a real kernel driver will have no need to
> arbitrate with itself.

I'll gladly review any custom HID drivers. Feel free to put me on CC
when sending to linux-input. There's also a lot of examples in
drivers/hid/ in case you need a head-start (especially if you need the
raw_event callback).

Thanks
David
