From: Adam Sutton <dev@adamsutton.me.uk>
Subject: Re: HID-generic + HID-ANOTHER interaction problems
Date: Fri, 16 Nov 2012 16:24:27 +0000
Message-ID: <CANMoCi+HL7ehaGi-M6hfs--c5rUgt=pkVN5vLxmVmFAKJz-VGg@mail.gmail.com>
References: <CANMoCi+tRPAQVXdOOzODOHca-1JM3aZMfJrMn5GiD5G40F=WRQ@mail.gmail.com>
	<alpine.LNX.2.00.1211161626420.20577@pobox.suse.cz>
	<CANMoCi+ySTuYm_5Ne8fMwUFmDtJwzGsuSuXE9Dsjev_avONyQw@mail.gmail.com>
	<alpine.LNX.2.00.1211161635500.20577@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56689 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab2KPQY2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2012 11:24:28 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2942089obb.19
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2012 08:24:28 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1211161635500.20577@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 16 November 2012 15:39, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 16 Nov 2012, Adam Sutton wrote:
>
>> Ta - just noticed I mailed from wrong address so original post did not go
>> to mailing list.
>>
>> 1. the unbind/bind was actually the first thing I tried (should have
>> mentioned that) before resorting to removing hid-generic. This worked fine
>> for me in the past when I had loaded my own precursor to the current
>> hid-spinelplus remote. However when I tried it with the latest code it
>> simply resulted in an unusable remote (nothing worked) it didn't even work
>> when I remapped back to hid-generic. So something is broken there?
>
> Was this some kernel between 3.7-rc1 and 3.7-rc5? There was a bug in
> rebinding drivers to devices which got fixed by commit df0cfd69903 in
> Linus' tree.

No we're a bit behind the curve, I think we're using a 3.6 based
kernel.  I didn't really investigate the problem, simply noted that it
didn't work (as it had before) and moved on to try and figure out
another way to make it work.

>
>> 2. Sure I can see about doing that :) Maybe you could have a quick look at
>> the code here (
>> https://github.com/OpenELEC/OpenELEC.tv/blob/master/packages/linux/patches/linux-3.6.6-053-spinelplus-remote-0.1.patch)
>> to see if there is anything needs changing (the hid_have_special_driver[]
>> mods aside) before it will be accepted.
>
> The driver looks fine, but as it contains solely usage -> keycode mapping,
> it should be possible to do it completely in userspace. There are already
> a lot of udev rules for this you can use for inspiration -- in recent udev
> releases they are located in /lib/udev/rules.d/keymaps, and are handled by
> master /lib/udev/rules.d/*keymap* rule.

I'll take a look at that. I can see there are plenty of other drivers
though in the mainline that do the same thing we're doing with the
spinelplus. Are these simply relics of and older approach (before udev
updates?) or is there a benefit to doing this in the kernel?

Either way would you still be happy to accept the patch? And if so
what exactly is the process for submitting, I've had a quick read
on-line. Do I simply need to generate a git patch and post to the
mailing list?

Ta
Adam
