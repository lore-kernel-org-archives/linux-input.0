From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Tue, 22 Jun 2010 15:24:24 +0200
Message-ID: <201006221524.25084.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <201006182041.54115.oliver@neukum.org> <201006221306.13420.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:35075 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab0FVNX7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 09:23:59 -0400
In-Reply-To: <201006221306.13420.linux@rainbow-software.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

Am Dienstag, 22. Juni 2010, 13:06:12 schrieb Ondrej Zary:
> On Friday 18 June 2010, Oliver Neukum wrote:
> > Am Freitag, 18. Juni 2010 20:34:03 schrieb Ondrej Zary:
> > > On Friday 18 June 2010 20:22:07 Oliver Neukum wrote:
> > > > Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > > > > > I haven't tested the patches before. Now I tested them and the
> > > > > > > Nexio touchscreen does not play well with suspend. It always
> > > > > > > reconnects after resume from STR or hibernation. Autosuspend is
> > > > > > > probably never activated at the URBs are submitted continuously.
> > > > > >
> > > > > > I see. Can you compile with CONFIG_USB_DEBUG and send me the log?
> > > > >
> > > > > This can't be fixed - no matter what you do, the device reconnects if
> > > > > you stop talking to it.
> > > >
> > > > Have you tried setting it back to config 0?
> > >
> > > No, I haven't. It reconnects even if there's no driver loaded (e.g. older
> > > kernel). I don't know if kernel sets configuration on all USB devices
> > > upon connect (even if there's no driver).
> >
> > Yes, the kernel sets a configuration if the power budget allows it.
> > You can set it back to 0 through sysfs and see what happens.
> 
> It disconnects and reconnects after bConfigurationValue is set to 0.

This is a violation of the spec. Can you give me the IDs so that I can
put the devices into the quirks file? Or can I take this from the driver?
Do all devices that marked as always needing an irq transfer behave
this way?

	Regards
		Oliver
