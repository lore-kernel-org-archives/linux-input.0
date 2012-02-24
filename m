From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: disable touchpad?
Date: Fri, 24 Feb 2012 16:37:52 -0600
Message-ID: <20120224223752.GA9883@ubuntu-macmini>
References: <4F47ED34.1070406@xenotime.net>
 <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com>
 <4F480EBA.7020509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58300 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab2BXWhz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 17:37:55 -0500
Content-Disposition: inline
In-Reply-To: <4F480EBA.7020509@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>, Randy Dunlap <rdunlap@xenotime.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Feb 24, 2012 at 02:27:06PM -0800, Chase Douglas wrote:
> On 02/24/2012 01:31 PM, Dmitry Torokhov wrote:
> >On Friday, February 24, 2012 12:04:04 PM Randy Dunlap wrote:
> >>(b) My Toshiba Portege laptop has a touchpad on/off button.  Is that
> >>supported?
> >
> >Kernel probably emits one of KEY_TOUCHPAD_* for it; whether it is handled
> >in userspace I do not know.
> 
> I have heard from some of our engineers who have looked into this
> that the interface for these buttons is not standardized. Sometimes
> the buttons turn off the touchpad in hardware. Sometimes they emit
> events that tell the OS to turn it off, and the OS needs to know how
> to handle it.
> 
> On top of that, LEDs are sometimes there to tell you if the trackpad
> is on or off. These are also not standardized. Sometimes they are
> hooked up to the hardware, and when the hardware is off they go off.
> Sometimes they are just a plain old LED and the OS needs to turn it
> on and off.
> 
> Fun...

I've worked with a few Toshibas, and while there's quite a bit of
variation within Toshiba models, all the ones I've seen report a key
event rather than disabling the touchpad in firmware. Some of them
report the key on the AT keyboard while others use a Toshiba-specific
ACPI interface.

Randy, if you can't find a key event currently being emitted on your
machine, I have some patches for toshiba_acpi to enable hotkeys for some
Toshibas [1].  You might give them a try.

Seth

[1] https://lkml.org/lkml/2012/1/18/328
