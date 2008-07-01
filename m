From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 12:02:59 -0400
Message-ID: <20080701120222.ZZRA012@mailhub.coreip.homeip.net>
References: <20080701085504.ZZRA012@mailhub.coreip.homeip.net> <Pine.LNX.4.44L0.0807011058340.2780-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0807011058340.2780-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 01, 2008 at 11:00:10AM -0400, Alan Stern wrote:
> On Tue, 1 Jul 2008, Dmitry Torokhov wrote:
> 
> > > The user has decided to put the device in a state in which the driver
> > > cannot properly function. If the user wanted the driver to work, he should
> > > select autosuspend.
> > >
> > 
> > That is the thing with the forced suspend - it leaves device out of
> > sync with the rest of the system. If user really does not want to use
> > the device it should probably be completely disconnected?
> 
> Some devices are rather difficult to disconnect (the cabling may be 
> inaccessible).
> 
> Also, devices can be suspended by software, but generally speaking they 
> cannot be disconnected by software.

By disconnecting I meant unbinding the driver really.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
