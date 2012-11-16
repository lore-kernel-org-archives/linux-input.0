From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID-generic + HID-ANOTHER interaction problems
Date: Fri, 16 Nov 2012 17:37:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211161734570.20577@pobox.suse.cz>
References: <CANMoCi+tRPAQVXdOOzODOHca-1JM3aZMfJrMn5GiD5G40F=WRQ@mail.gmail.com> <alpine.LNX.2.00.1211161626420.20577@pobox.suse.cz> <CANMoCi+ySTuYm_5Ne8fMwUFmDtJwzGsuSuXE9Dsjev_avONyQw@mail.gmail.com> <alpine.LNX.2.00.1211161635500.20577@pobox.suse.cz>
 <CANMoCi+HL7ehaGi-M6hfs--c5rUgt=pkVN5vLxmVmFAKJz-VGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49585 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057Ab2KPQh3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2012 11:37:29 -0500
In-Reply-To: <CANMoCi+HL7ehaGi-M6hfs--c5rUgt=pkVN5vLxmVmFAKJz-VGg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adam Sutton <dev@adamsutton.me.uk>
Cc: linux-input@vger.kernel.org

On Fri, 16 Nov 2012, Adam Sutton wrote:

> >> 2. Sure I can see about doing that :) Maybe you could have a quick look at
> >> the code here (
> >> https://github.com/OpenELEC/OpenELEC.tv/blob/master/packages/linux/patches/linux-3.6.6-053-spinelplus-remote-0.1.patch)
> >> to see if there is anything needs changing (the hid_have_special_driver[]
> >> mods aside) before it will be accepted.
> >
> > The driver looks fine, but as it contains solely usage -> keycode mapping,
> > it should be possible to do it completely in userspace. There are already
> > a lot of udev rules for this you can use for inspiration -- in recent udev
> > releases they are located in /lib/udev/rules.d/keymaps, and are handled by
> > master /lib/udev/rules.d/*keymap* rule.
> 
> I'll take a look at that. I can see there are plenty of other drivers
> though in the mainline that do the same thing we're doing with the
> spinelplus. Are these simply relics of and older approach (before udev
> updates?) or is there a benefit to doing this in the kernel?

Exactly as you mention, it's a relic from the times when you were not able 
to change HID usages by 'setkeycodes', so the in-kernel driver changing 
the mapping was the only option.

Now there are much more mappings being done from userspace instead of the 
kernel, but we can't really remove the ones which are already in-kernel, 
as that might cause regressions for people with old udev whould would 
update to latest kernel.

> Either way would you still be happy to accept the patch? And if so
> what exactly is the process for submitting, I've had a quick read
> on-line. Do I simply need to generate a git patch and post to the
> mailing list?

Yes, that is the usual process.

But for these kinds of drivers, I'd really suggest you actually convert it 
to a udev rule and submit it as a patch to udev maintainers instead.

Does that work for you?

Thanks,

-- 
Jiri Kosina
SUSE Labs
