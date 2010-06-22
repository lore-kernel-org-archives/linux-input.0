From: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Tue, 22 Jun 2010 15:43:24 +0200
Message-ID: <201006221543.27169.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <201006221306.13420.linux@rainbow-software.org> <201006221524.25084.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006221524.25084.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tuesday 22 June 2010, Oliver Neukum wrote:
> Am Dienstag, 22. Juni 2010, 13:06:12 schrieb Ondrej Zary:
> > On Friday 18 June 2010, Oliver Neukum wrote:
> > > Am Freitag, 18. Juni 2010 20:34:03 schrieb Ondrej Zary:
> > > > On Friday 18 June 2010 20:22:07 Oliver Neukum wrote:
> > > > > Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > > > > > > I haven't tested the patches before. Now I tested them and
> > > > > > > > the Nexio touchscreen does not play well with suspend. It
> > > > > > > > always reconnects after resume from STR or hibernation.
> > > > > > > > Autosuspend is probably never activated at the URBs are
> > > > > > > > submitted continuously.
> > > > > > >
> > > > > > > I see. Can you compile with CONFIG_USB_DEBUG and send me the
> > > > > > > log?
> > > > > >
> > > > > > This can't be fixed - no matter what you do, the device
> > > > > > reconnects if you stop talking to it.
> > > > >
> > > > > Have you tried setting it back to config 0?
> > > >
> > > > No, I haven't. It reconnects even if there's no driver loaded (e.g.
> > > > older kernel). I don't know if kernel sets configuration on all USB
> > > > devices upon connect (even if there's no driver).
> > >
> > > Yes, the kernel sets a configuration if the power budget allows it.
> > > You can set it back to 0 through sysfs and see what happens.
> >
> > It disconnects and reconnects after bConfigurationValue is set to 0.
>
> This is a violation of the spec. Can you give me the IDs so that I can
> put the devices into the quirks file? Or can I take this from the driver?
> Do all devices that marked as always needing an irq transfer behave
> this way?

This is not a bug surprise as this device is broken in many ways. It takes 
ages to detect and identify and looks like cdc_acm. The pseudo-multitouch 
capable protocol is pretty bad too. Also there are some reports about devices 
using the same ID but different protocol.

I have only one - 1870:0001, don't know anything about the other.

-- 
Ondrej Zary
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
