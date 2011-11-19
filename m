From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Supporting Battery Strength from my Bluetooth Mouse
Date: Sat, 19 Nov 2011 12:18:04 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
References: <4EC75224.7070207@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58225 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab1KSLSI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Nov 2011 06:18:08 -0500
In-Reply-To: <4EC75224.7070207@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-input@vger.kernel.org, vojtech@ucw.cz

On Fri, 18 Nov 2011, Jeremy Fitzhardinge wrote:

> My Bluetooth mouse (HP branded, but some generic Taiwanese innards)
> supports reporting its battery level.
> 
> The data appears in its HID descriptor as:
> 
>   INPUT(3)[INPUT]
>     Field(0)
>       Usage(1)
>         0006.0020
>       Logical Minimum(0)
>       Logical Maximum(255)
>       Report Size(8)
>       Report Count(1)
>       Report Offset(0)
>       Flags( Variable Absolute )
> 
> which is consistent with the USB HID Usage Tables 1.12 spec, which lists
> Usage Page 6 as Generic Device Controls and Usage ID 0x20 as Battery
> Strength.  I'm assuming that this is commonplace on battery-powered
> mice, but I only have one to check.
> 
> I've written an (untested) patch to display this correctly in debugfs.
> (below)

Hi Jeremy,

the debugfs patch is obviously correct(tm), so I will be queuing it, 
thanks.

> My real question is how to get this out to somewhere useful, where 
> (ultimately) some GUI could show the battery information if its 
> available?

Actually the proper way to do this is using power_supply class.

There alreasy is a HID driver that does this properly, and it's rather 
easy. Check drivers/hid/hid-wacom.c, especially all the code which is 
#ifdef CONFIG_HID_WACOM_POWER_SUPPLY

> (Hm, and I wonder what makes the mouse actually report the battery 
> level; I guess I'll only ever see a report if it actually changes.)

I'd expect that as a "default" behavior, yes. Unfortunately it might also 
be possible that there is some vendor-specific way to actually query the 
battery state, but it'd be difficult to find out without actually snooping 
the behavior in some other OS.

But as long as it contains proper entry in report descriptor, I'd expect 
it to send the report on its own.

-- 
Jiri Kosina
SUSE Labs
