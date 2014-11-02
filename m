From: Tom Gundersen <teg@jklm.no>
Subject: Re: [systemd-devel] Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 22:59:07 +0100
Message-ID: <CAG-2HqVW0N8tFgkqjNHSrMgXwaN-oWCjTO4V1kyu1znnSDvu=A@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <CAG-2HqVug0hixSm5Lad7pVSZgJOm4smbL=2jzmREz4Zwk2zghw@mail.gmail.com> <CALCETrUCiK7t0vT=N9Od3itKuQBYQUescMfmdXfD_fWCZdw3hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f52.google.com ([209.85.213.52]:37012 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaKBV72 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 16:59:28 -0500
Received: by mail-yh0-f52.google.com with SMTP id a41so4277377yho.11
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2014 13:59:27 -0800 (PST)
In-Reply-To: <CALCETrUCiK7t0vT=N9Od3itKuQBYQUescMfmdXfD_fWCZdw3hw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Nov 2, 2014 at 10:13 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Sun, Nov 2, 2014 at 12:47 PM, Tom Gundersen <teg@jklm.no> wrote:
>> Hi Andy,
>>
>> On Sun, Nov 2, 2014 at 7:57 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> I want to get U2F (universal second factor, sometimes called "security
>>> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
>>> that speak a custom protocol.  The intent is that user code will speak
>>> to then using something like HIDAPI.
>>>
>>> The trick is that, for HIDAPI to work, something needs to recognize
>>> these devices and get udev to set appropriate device permissions.
>>>
>>> My question is: how should this be done?  The official way to
>>> enumerate U2F devices is to look for a HID usage page 0xf1d0
>>> containing usage 0x1.
>>>
>>> Options include:
>>>
>>>  - A builtin udev helper that reads the sysfs report_descriptor for
>>> hid or hidraw devices and sets attributes accordingly (either
>>> ID_SECURITY_TOKEN or something more general).
>>
>> I don't think we should have such special-purpose logic in the udev core.
>>
>> [...]
>>
>>> - HID core code in the kernel to add
>>> HID_USAGES=f1d00001:lots:of:other:things to the uevent (or udev code
>>> to do the same).  This might end up producing a rather long string or
>>> some devices.
>>
>> This makes the most sense to me. We could put this logic (adapting the
>> patch you posted) in src/udev/udev-builtin-usb_id.c.
>
> How would that work?  Can't a USB device have more than one HID class
> device under it?  I could imagine a future U2F keyboard that has a HID
> class device for the keyboard part and another one for U2F.

Right, a separate built-in makes more sense then.

Cheers,

Tom
