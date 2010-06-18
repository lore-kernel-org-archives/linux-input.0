From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Fri, 18 Jun 2010 20:41:54 +0200
Message-ID: <201006182041.54115.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <201006182022.07496.oliver@neukum.org> <201006182034.05793.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006182034.05793.linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Freitag, 18. Juni 2010 20:34:03 schrieb Ondrej Zary:
> On Friday 18 June 2010 20:22:07 Oliver Neukum wrote:
> > Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > > > I haven't tested the patches before. Now I tested them and the Nexio
> > > > > touchscreen does not play well with suspend. It always reconnects
> > > > > after resume from STR or hibernation. Autosuspend is probably never
> > > > > activated at the URBs are submitted continuously.
> > > >
> > > > I see. Can you compile with CONFIG_USB_DEBUG and send me the log?
> > >
> > > This can't be fixed - no matter what you do, the device reconnects if you
> > > stop talking to it.
> >
> > Have you tried setting it back to config 0?
> 
> No, I haven't. It reconnects even if there's no driver loaded (e.g. older 
> kernel). I don't know if kernel sets configuration on all USB devices upon 
> connect (even if there's no driver).

Yes, the kernel sets a configuration if the power budget allows it.
You can set it back to 0 through sysfs and see what happens.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
