From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID-generic + HID-ANOTHER interaction problems
Date: Fri, 16 Nov 2012 16:39:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211161635500.20577@pobox.suse.cz>
References: <CANMoCi+tRPAQVXdOOzODOHca-1JM3aZMfJrMn5GiD5G40F=WRQ@mail.gmail.com> <alpine.LNX.2.00.1211161626420.20577@pobox.suse.cz> <CANMoCi+ySTuYm_5Ne8fMwUFmDtJwzGsuSuXE9Dsjev_avONyQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47252 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab2KPPjv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2012 10:39:51 -0500
In-Reply-To: <CANMoCi+ySTuYm_5Ne8fMwUFmDtJwzGsuSuXE9Dsjev_avONyQw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Adam Sutton <dev@adamsutton.me.uk>
Cc: linux-input@vger.kernel.org

On Fri, 16 Nov 2012, Adam Sutton wrote:

> Ta - just noticed I mailed from wrong address so original post did not go
> to mailing list.
> 
> 1. the unbind/bind was actually the first thing I tried (should have
> mentioned that) before resorting to removing hid-generic. This worked fine
> for me in the past when I had loaded my own precursor to the current
> hid-spinelplus remote. However when I tried it with the latest code it
> simply resulted in an unusable remote (nothing worked) it didn't even work
> when I remapped back to hid-generic. So something is broken there?

Was this some kernel between 3.7-rc1 and 3.7-rc5? There was a bug in 
rebinding drivers to devices which got fixed by commit df0cfd69903 in 
Linus' tree.

> 2. Sure I can see about doing that :) Maybe you could have a quick look at
> the code here (
> https://github.com/OpenELEC/OpenELEC.tv/blob/master/packages/linux/patches/linux-3.6.6-053-spinelplus-remote-0.1.patch)
> to see if there is anything needs changing (the hid_have_special_driver[]
> mods aside) before it will be accepted.

The driver looks fine, but as it contains solely usage -> keycode mapping, 
it should be possible to do it completely in userspace. There are already 
a lot of udev rules for this you can use for inspiration -- in recent udev 
releases they are located in /lib/udev/rules.d/keymaps, and are handled by 
master /lib/udev/rules.d/*keymap* rule.

Hope this helps,

-- 
Jiri Kosina
SUSE Labs
