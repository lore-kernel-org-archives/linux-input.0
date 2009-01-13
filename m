From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] Add N-Trig to USB HID quirks
Date: Tue, 13 Jan 2009 12:01:34 -0500
Message-ID: <496CC8EE.5030105@seas.upenn.edu>
References: <1231838198.8132.27.camel@micki-desktop.n-trig.com> <20090113103323.26dbe085@lxorguk.ukuu.org.uk> <alpine.LNX.1.10.0901131136470.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stag.SEAS.UPENN.EDU ([158.130.70.79]:54275 "EHLO
	stag.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbZAMRBw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jan 2009 12:01:52 -0500
In-Reply-To: <alpine.LNX.1.10.0901131136470.5377@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Micki <micki@n-trig.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jiri Kosina wrote:
> On Tue, 13 Jan 2009, Alan Cox wrote:
>
>>> The N-trig Solution will consist of:
>>>
>>> 1. Kernel driver: The purpose of this driver is to translate USB
>>> messages into input events. For example, EV_KEY, EV_ABS.
>>>
>>> 2. X11 input driver: The purpose of the X11 is to simulate X11 events,
>>> according to input received from the driver.
>> The ignore patch should go with the kernel driver patch and be submitted
>> together I think
>
> Moreover, this device ID has been already added by Rafi Rubin (added to
> CC), together with the simple driver for this device (see
> drivers/hid/hid-ntrig.c in recent kernels).
>

The patches I wrote make minimal pertubations to help the hid driver recognize and communicate with
the digitizer.  The result has been an event device that actually works reasonably well with the
existing X11 wacom driver (at least with version 0.8.1.6).

That much was intended as preliminary support until I had time to figure out the multi-finger
support and other features.  I don't want my work to block better support from people who are
actually familiar with the workings of the device.  Please at least read what's been added, before
building a whole new driver.

Also you should know people have been talking about a general multi-touch protocol on the
linux-input list.  Perhaps N-Trig can help with that.  And perhaps you will benefit from the work
they are doing.


I would like to offer my personal assistance with the development and testing of both the kernel and
X drivers.  A number of other linux users with n-trig digitizers have contacted me, I suspect some
of them would be willing to help with testing.

And I've also had a few ideas about features and user interfaces that I'd like to see in an X driver
or utilities.

Rafi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklsyO4ACgkQwuRiAT9o60/LSQCfTf/S9t3VkFVa6ACHenfBXhzO
orMAn1Qpy/eK7C+R9DlUvg/uwp6NwAu9
=V0Fw
-----END PGP SIGNATURE-----
