From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [0000/0003]full power management for usb touchscreens
Date: Thu, 10 Jun 2010 16:25:10 +0200
Message-ID: <201006101625.10897.oliver@neukum.org>
References: <201006071513.29478.oneukum@suse.de> <201006101546.55460.oliver@neukum.org> <201006101613.52736.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201006101613.52736.linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ondrej Zary <linux-ZCIryABCsrmttCpgsWEBFmD2FQJk+8+b@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Am Donnerstag, 10. Juni 2010 16:13:51 schrieb Ondrej Zary:
> > > I haven't tested the patches before. Now I tested them and the Nexio
> > > touchscreen does not play well with suspend. It always reconnects after
> > > resume from STR or hibernation. Autosuspend is probably never activated
> > > at the URBs are submitted continuously.
> >
> > I see. Can you compile with CONFIG_USB_DEBUG and send me the log?
> 
> This can't be fixed - no matter what you do, the device reconnects if you stop 
> talking to it.

Even if you immediately go into suspend?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
