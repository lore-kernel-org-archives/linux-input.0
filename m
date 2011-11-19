From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Sat, 19 Nov 2011 13:34:48 -0800
Message-ID: <4EC820F8.4070900@goop.org>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:53436 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538Ab1KSVey (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Nov 2011 16:34:54 -0500
In-Reply-To: <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz

On 11/19/2011 03:18 AM, Jiri Kosina wrote:
> the debugfs patch is obviously correct(tm), so I will be queuing it, 
> thanks.

Thanks.

>> My real question is how to get this out to somewhere useful, where 
>> (ultimately) some GUI could show the battery information if its 
>> available?
> Actually the proper way to do this is using power_supply class.
>
> There alreasy is a HID driver that does this properly, and it's rather 
> easy. Check drivers/hid/hid-wacom.c, especially all the code which is 
> #ifdef CONFIG_HID_WACOM_POWER_SUPPLY

Hm, OK.  I wonder what the descriptor for that device looks like; I
wonder if it already uses Battery Strength, but just hard-coded?

Given that this is a generic HID thing, where should it go?  Should
hid-core.c go around trying to create new power supplies?

Seems to me that there's a good chance that random devices will claim to
supply Battery Strength info even if they don't have batteries because
they happen to share firmware with a device that does (similarly, its
amazing how many keys my keyboard is missing according to the
descriptor).  I guess the best way to handle it is have a hid-core
helper function which will register a power_supply if the driver asks it
to (and the descriptor contains Battery Strength).  Bluetooth, for
example, has a separate descriptor entry about whether the device is
battery powered which is much more likely to be accurate than the
generic HID descriptor, and it can call the power supply helper as part
of the HID setup.

Does that sound reasonable?

>> (Hm, and I wonder what makes the mouse actually report the battery 
>> level; I guess I'll only ever see a report if it actually changes.)
> I'd expect that as a "default" behavior, yes. Unfortunately it might also 
> be possible that there is some vendor-specific way to actually query the 
> battery state, but it'd be difficult to find out without actually snooping 
> the behavior in some other OS.
>
> But as long as it contains proper entry in report descriptor, I'd expect 
> it to send the report on its own.

My reading of the evdev documentation is that it would suppress
duplicate reports to usermode, so my little program wouldn't see any
events from /dev/input/eventX unless there were a change anyway, is that
right?

Thanks,
    J
