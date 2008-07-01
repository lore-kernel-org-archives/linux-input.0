From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 18:57:01 +0200
Message-ID: <200807011857.02259.oliver@neukum.org>
References: <20080630112709.ZZRA012@mailhub.coreip.homeip.net> <200807011108.48556.oliver@neukum.org> <20080701085504.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080701085504.ZZRA012-NG0XCrj25/nJrYCpivWRnl5pS2h4L8biXqFh9Ls21Oc@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Dienstag 01 Juli 2008 14:56:30 schrieb Dmitry Torokhov:
> On Tue, Jul 01, 2008 at 11:08:47AM +0200, Oliver Neukum wrote:
> > Am Dienstag 01 Juli 2008 09:59:01 schrieb Jiri Kosina:

> > > I really don't think we want to return error in such cases. Either resume 
> > > the device, or queue some requests (maybe depending on the type of 
> > > requests), right?
> > 
> > We are talking about forcibly suspended devices, so they cannot be
> > resumed. We could queue, but where would we end queuing? And we
> > have to decide to stop it at some point, or we create a DoS problem.
> > 
> > The user has decided to put the device in a state in which the driver
> > cannot properly function. If the user wanted the driver to work, he should
> > select autosuspend.
> >
> 
> That is the thing with the forced suspend - it leaves device out of
> sync with the rest of the system. If user really does not want to use
> the device it should probably be completely disconnected?

Yes, therefore I suggested doing the logical disconnect.

The drawback is that we lose all settings made on the device. But
to keep those we have autosuspend. It's true that currently many drivers lack
support for autosuspend, but the API should be designed for the final state.

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
