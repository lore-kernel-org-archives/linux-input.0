From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Supporting U2F over HID on Linux?
Date: Sun, 2 Nov 2014 21:42:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411022134120.19451@pobox.suse.cz>
References: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbaKBUms (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Nov 2014 15:42:48 -0500
In-Reply-To: <CALCETrXKcU1KaEjFUm9QkEhZRh9wFnoR=hV7O9pUJmYRqNCxpg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kay Sievers <kay@vrfy.org>, Greg KH <gregkh@linuxfoundation.org>, systemd Mailing List <systemd-devel@lists.freedesktop.org>, linux-input@vger.kernel.org

On Sun, 2 Nov 2014, Andy Lutomirski wrote:

> I want to get U2F (universal second factor, sometimes called "security
> key" or even "gnubby") working on Linux.  U2F tokens are HID devices
> that speak a custom protocol.  The intent is that user code will speak
> to then using something like HIDAPI.
> 
> The trick is that, for HIDAPI to work, something needs to recognize
> these devices and get udev to set appropriate device permissions.

Just to make sure we are on the same page -- this is really only about 
setting proper device node permissions and nothing else, right?

> My question is: how should this be done?  The official way to
> enumerate U2F devices is to look for a HID usage page 0xf1d0
> containing usage 0x1.
> 
> Options include:
> 
>  - A builtin udev helper that reads the sysfs report_descriptor for
> hid or hidraw devices and sets attributes accordingly (either
> ID_SECURITY_TOKEN or something more general).

Hmmm ... please keep in mind that report_descriptor is actually in 
debugfs, so it's a bit questionable whether you can rely on it being 
present on well-defined location on all systems.

You can get it from different other places though, such as libusb (but 
then you are limited only to USB HID devices ... which might be enough 
in your particular case).

> - A udev helper that does this and doesn't live in the systemd tree.
> I don't love this option -- I'd prefer for this to be as plug-and-play
> as possible.

Agreed.

> - HID core code in the kernel to add
> HID_USAGES=f1d00001:lots:of:other:things to the uevent (or udev code
> to do the same).  This might end up producing a rather long string or
> some devices.

We have been thinking about this quite a lot in the past, and decided to 
postpone this until there is a very good reason for it to happen.

>  - An actual kernel driver for U2F devices using the hid group
> mechanism for enumeration.  This seems overcomplicated.

Hmmm ... why do you think so? I believe it actually should be really 
super-trivial.

Thanks,

-- 
Jiri Kosina
SUSE Labs
