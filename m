From: Oliver Neukum <oliver@neukum.org>
Subject: Re: proposal on runtime power management in hid
Date: Fri, 31 Oct 2008 10:26:28 +0100
Message-ID: <200810311026.29916.oliver@neukum.org>
References: <200810301704.01005.oliver@neukum.org> <alpine.LNX.1.10.0810310015250.31273@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:46749 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYJaJ03 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 05:26:29 -0400
In-Reply-To: <alpine.LNX.1.10.0810310015250.31273@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jslaby@suse.cz>, linux-pm@vger.kernel.org, pavel@ucw.cz

Am Freitag, 31. Oktober 2008 00:17:38 schrieb Jiri Kosina:
> On Thu, 30 Oct 2008, Oliver Neukum wrote:
> 
> > I am looking at runtime power management for usb hid devices. There's a 
> > problem with hidraw. As we have no idea, what goes on between a device 
> > and users of hidraw, it seems to me that such a device should not be 
> > subject to runtime power management without the user's explicit 
> > agreement. But that would be only a kludge. Therefore this is my first 
> > draft of an API to cleanly allow this.
> 
> Hi Oliver,
> 
> isn't this just a little bit way too complex?

That depends on the eventual goal. If hidraw were the only problem,
I could find a simpler solution.

> I think the simple and working solution would be never suspedning devices 
> that have interface open through hidraw, unless user explicitly allows 
> this through respective power/autosuspend setting in sysfs (which will by 
> default be set to 'off' for HID devices anyway, right?).

That we already have. That's the simple copout. Do not enable autosuspend
if you allow hidraw for a device. However, if normal users shall be able to use
the hidraw device that means that autosuspend can never be enabled for the
device, as we don't know when someone will use the device.

For hiddev we can do better, the device is not autosuspended while it is
open. This allows allowing ordinary users to use the device. Doing so for
hidraw would require to extended the low level hid API. But not as extensively
as I suggested.

But I consider this to be a lost opportunity.
Currently the ll driver must assume that the device is required to be fully
operational when it is open. This means different things for ordinary input
devices and "raw" devices. Raw devices must not be autosuspended when
open at all. Ordinary devices must be able to process input.

But that is often overkill. In many situations, for example when a the screen
saver is running, you only care that a key has been pressed, not which key.
Drivers can save more power if they know this.

Quote Alan Stern:
> Would it make more sense never to autosuspend a device that has an open
> hidraw interface?  Then if you want to, you could add an API allowing

That is the sane default.

> the user to tell the kernel to suspend or to resume (if the existing
> sysfs interface isn't sufficient).

The existing sysfs interface is clearly not designed for this. It's designed
for system administration work. We are talking about ordinary user tasks
accessing a generic interface. This leads to the following deficiencies:

- the sysfs interface is specific to USB, hidraw is for all HID devices
- the sysfs interface operates on physical devices, hidraw on logical devices
- the sysfs interface is not designed to be shared among tasks
- user space tasks know a device node, not the sysfs directory

	Regards
		Oliver
