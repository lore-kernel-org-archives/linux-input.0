From: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Thu, 10 Jun 2010 16:13:51 +0200
Message-ID: <201006101613.52736.linux@rainbow-software.org>
References: <201006071513.29478.oneukum@suse.de> <201006101333.58693.linux@rainbow-software.org> <201006101546.55460.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006101546.55460.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thursday 10 June 2010, Oliver Neukum wrote:
> Am Donnerstag, 10. Juni 2010 13:33:57 schrieb Ondrej Zary:
> > On Wednesday 09 June 2010, Oliver Neukum wrote:
> > > Am Mittwoch, 9. Juni 2010 15:40:04 schrieb Ondrej Zary:
> > > > Looking at the patches from archive:
> > > >
> > > > If I understand it correctly, usbtouch_resume submits the irq URB
> > > > only if the input device is open. That will fail with Nexio as it has
> > > > an internal watchdog which needs URBs or the device will reconnect -
> > > > see irq_always (Zytronic seems to need it too).
> > >
> > > Thank you for the review. Does this patch fix the issues?
> >
> > I haven't tested the patches before. Now I tested them and the Nexio
> > touchscreen does not play well with suspend. It always reconnects after
> > resume from STR or hibernation. Autosuspend is probably never activated
> > at the URBs are submitted continuously.
>
> I see. Can you compile with CONFIG_USB_DEBUG and send me the log?

This can't be fixed - no matter what you do, the device reconnects if you stop 
talking to it.

-- 
Ondrej Zary
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
