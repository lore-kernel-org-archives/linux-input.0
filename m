From: Adam Sutton <aps@adamsutton.co.uk>
Subject: Re: HID-generic + HID-ANOTHER interaction problems
Date: Fri, 16 Nov 2012 16:41:10 +0000
Message-ID: <CANMoCiL23iKOzGJMKvcfpj-XPbt3c+Wq8USGhRQd72NYKs4kVg@mail.gmail.com>
References: <CANMoCi+tRPAQVXdOOzODOHca-1JM3aZMfJrMn5GiD5G40F=WRQ@mail.gmail.com>
	<alpine.LNX.2.00.1211161626420.20577@pobox.suse.cz>
	<CANMoCi+ySTuYm_5Ne8fMwUFmDtJwzGsuSuXE9Dsjev_avONyQw@mail.gmail.com>
	<alpine.LNX.2.00.1211161635500.20577@pobox.suse.cz>
	<CANMoCi+HL7ehaGi-M6hfs--c5rUgt=pkVN5vLxmVmFAKJz-VGg@mail.gmail.com>
	<alpine.LNX.2.00.1211161734570.20577@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49476 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739Ab2KPQlL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2012 11:41:11 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2960208obb.19
        for <linux-input@vger.kernel.org>; Fri, 16 Nov 2012 08:41:10 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1211161734570.20577@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 16 November 2012 16:37, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 16 Nov 2012, Adam Sutton wrote:
>
>> >> 2. Sure I can see about doing that :) Maybe you could have a quick look at
>> >> the code here (
>> >> https://github.com/OpenELEC/OpenELEC.tv/blob/master/packages/linux/patches/linux-3.6.6-053-spinelplus-remote-0.1.patch)
>> >> to see if there is anything needs changing (the hid_have_special_driver[]
>> >> mods aside) before it will be accepted.
>> >
>> > The driver looks fine, but as it contains solely usage -> keycode mapping,
>> > it should be possible to do it completely in userspace. There are already
>> > a lot of udev rules for this you can use for inspiration -- in recent udev
>> > releases they are located in /lib/udev/rules.d/keymaps, and are handled by
>> > master /lib/udev/rules.d/*keymap* rule.
>>
>> I'll take a look at that. I can see there are plenty of other drivers
>> though in the mainline that do the same thing we're doing with the
>> spinelplus. Are these simply relics of and older approach (before udev
>> updates?) or is there a benefit to doing this in the kernel?
>
> Exactly as you mention, it's a relic from the times when you were not able
> to change HID usages by 'setkeycodes', so the in-kernel driver changing
> the mapping was the only option.
>
> Now there are much more mappings being done from userspace instead of the
> kernel, but we can't really remove the ones which are already in-kernel,
> as that might cause regressions for people with old udev whould would
> update to latest kernel.

Thanks for the clarification.

>> Either way would you still be happy to accept the patch? And if so
>> what exactly is the process for submitting, I've had a quick read
>> on-line. Do I simply need to generate a git patch and post to the
>> mailing list?
>
> Yes, that is the usual process.
>
> But for these kinds of drivers, I'd really suggest you actually convert it
> to a udev rule and submit it as a patch to udev maintainers instead.
>
> Does that work for you?

Yes I think it does. Short term I've simply fixed the patch to mod
hid-core.c as you suggested, that will solve the immediate problem.

I'll talk to Stephen about the fact he might want to consider
investigating use of udev keymap rules. I had a quick look on my
laptop and they looked simply enough to do.

Thanks for all the help,

Adam
