From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Tue, 22 Jun 2010 13:06:12 +0200
Message-ID: <201006221306.13420.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <201006182034.05793.linux@rainbow-software.org> <201006182041.54115.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1-out1.atlantis.sk ([80.94.52.55]:59454 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759223Ab0FVLGS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Jun 2010 07:06:18 -0400
In-Reply-To: <201006182041.54115.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Daniel Ritz <daniel.ritz@gmx.ch>

On Friday 18 June 2010, Oliver Neukum wrote:
> Am Freitag, 18. Juni 2010 20:34:03 schrieb Ondrej Zary:
> > On Friday 18 June 2010 20:22:07 Oliver Neukum wrote:
> > > Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > > > > I haven't tested the patches before. Now I tested them and the
> > > > > > Nexio touchscreen does not play well with suspend. It always
> > > > > > reconnects after resume from STR or hibernation. Autosuspend is
> > > > > > probably never activated at the URBs are submitted continuously.
> > > > >
> > > > > I see. Can you compile with CONFIG_USB_DEBUG and send me the log?
> > > >
> > > > This can't be fixed - no matter what you do, the device reconnects if
> > > > you stop talking to it.
> > >
> > > Have you tried setting it back to config 0?
> >
> > No, I haven't. It reconnects even if there's no driver loaded (e.g. older
> > kernel). I don't know if kernel sets configuration on all USB devices
> > upon connect (even if there's no driver).
>
> Yes, the kernel sets a configuration if the power budget allows it.
> You can set it back to 0 through sysfs and see what happens.

It disconnects and reconnects after bConfigurationValue is set to 0.

-- 
Ondrej Zary
