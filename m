From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 14:49:37 -0800
Message-ID: <CALCETrVdaYnTU--9nmWUhcNeTO9eqheP_OsujVEB8yUM4AgzSg@mail.gmail.com>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
 <alpine.LNX.2.00.1411022134120.19451@pobox.suse.cz> <CALCETrVtA9rCDqAetaFj=tCo=ebWW43mA4f8n6fMZdCnE9TvgA@mail.gmail.com>
 <alpine.LNX.2.00.1411022229060.19451@pobox.suse.cz> <alpine.LNX.2.00.1411022239330.19451@pobox.suse.cz>
 <CAN+gG=HZ+CA3tWbHjG=ULUfztj87mLCoGQXT-5XLd-+vZ1K6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36919 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbaKBWt7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 17:49:59 -0500
Received: by mail-la0-f44.google.com with SMTP id gf13so8647544lab.31
        for <linux-input@vger.kernel.org>; Sun, 02 Nov 2014 14:49:57 -0800 (PST)
In-Reply-To: <CAN+gG=HZ+CA3tWbHjG=ULUfztj87mLCoGQXT-5XLd-+vZ1K6VA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, linux-input <linux-input@vger.kernel.org>

On Sun, Nov 2, 2014 at 2:45 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Sun, Nov 2, 2014 at 4:40 PM, Jiri Kosina <jkosina@suse.cz> wrote:
>> On Sun, 2 Nov 2014, Jiri Kosina wrote:
>>
>>> Alternatively, you can just write udev rule which triggers on HID devices,
>>> issues HIDIOCGRDESC ioctl() on the just-created hidraw node, and decides
>>> afterwards whether node permissions need to be altered ... right?
>>
>> Just to make myself clear here -- this is basically alternative to your
>> 1st option, but for cases where you want to make yourself independent on
>> sysfs existence (I don't what is the craziness level of setups you are
>> considering).
>>
>
> I am a little bit concerned with the user space retrieving the
> descriptor, parsing it and then deciding how to set the permissions.
> It's not that it is super complex, but it will duplicate the parsing
> we already do in the kernel. Wacom tried to do that in their usb
> driver, and they never managed to fully implement one.
>
> I think the HID_GROUP solution is super trivial:
> - add a match on the U2F input report and set the group to
> HID_GROUP_U2F (2 lines in hid_scan_input_usage() in hid-core.c)
> - allow hid-generic to also match HID_GROUP_U2F (1 line in hid-generic.c).
>
> Then, the udev rule would be super trivial.

I'm confused.  What would the user-visible effect of this be?  Would
the hidraw node still show up?  What is user code supposed to match to
detect a U2F device or to otherwise set permissions?

--Andy

>
> Also, if we want to further extend the kernel API for U2F, the group
> will already be in place.
>
> Cheers,
> Benjamin



-- 
Andy Lutomirski
AMA Capital Management, LLC
