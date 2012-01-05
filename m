From: Jan Steinhoff <mail@jan-steinhoff.de>
Subject: Re: [PATCH] input: Synaptics USB device driver
Date: Thu, 5 Jan 2012 05:39:57 +0000
Message-ID: <20120105053957.6f01ae73@greyhound>
References: <20120103194033.779cb829@greyhound>
	<alpine.LNX.2.00.1201040954000.24984@pobox.suse.cz>
	<201201041020.41795.oneukum@suse.de>
	<20120104094103.GA29069@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from unserver.de ([88.198.20.135]:44122 "EHLO unserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835Ab2AEFkD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Jan 2012 00:40:03 -0500
In-Reply-To: <20120104094103.GA29069@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Oliver Neukum <oneukum@suse.de>, Jiri Kosina <jkosina@suse.cz>, Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 4 Jan 2012 01:41:03 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Om, so I have been looking at the driver and the following seems to be
> still working with my Lenovo composite touchpad/stick.
> 
> Changes:
> 
> - the stick is reported in relative mode; we might consider addig
>   sensitivity control similar to trackpoint driver. Press-to-select -
>   maybe in driver, or in client; undecided.
> 
> - got rid of BTN_MISC/BTN_MIDDLE option (at least for now);

Please make BTN_MIDDLE the default in this case for the cPad. This
button is actually located where the middle button should be. Only if
one uses the cPad's background display it obtains a "special" meaning.
(Then pressing it should launch a menu on the background display and the
touchpad works as a touchscreen for this display.)

> - added devices to HID blacklist;

I think it is more flexible and save to use the manual driver binding
capability of the USB core instead:

http://lwn.net/Articles/143397/

Which driver to use for which device can then be set, e.g., with the
help of udev config files.

Blacklisting has the big disadvantage that the device will not work at
all if the synaptics-usb kernel module is not loaded/present, whereas
otherwise usbhid is used as the default. At least the corresponding
part in the blacklist should be enclosed in
#ifdef CONFIG_MOUSE_SYNAPTICS_USB ... #endif

Further, as noted in the initial comment, not all devices have been
tested with this driver. This is another reason to allow the user to
choose which driver to use.

> - runtime PM (hopefully I got it right);
> 
> - open/close.

I do not understand why needs_remote_wakeup is flipped in open/close.
As far as I know, the device can not autosuspend after
usb_autopm_get_interface was called anyway?

> Still TODO:
> 
> - query device for supported rages instead of having module
> parameters.

At least for the cPad the device does unfortunately not provide this
information. I tried to read the HID descriptors once but just got
errors. However, the defaults work quite well for all tested devices.
The module parameters are actually meant to just provide a simple
workaround in case one of the untested devices (especially the
touchscreen) might need them.

Thanks!

Jan
