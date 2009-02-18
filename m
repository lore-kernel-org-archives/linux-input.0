From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Wed, 18 Feb 2009 11:51:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902181150370.17341-100000@iolanthe.rowland.org>
References: <200902172142.57302.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200902172142.57302.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Laurent Riffard <laurent.riffard-GANU6spQydw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 17 Feb 2009, Oliver Neukum wrote:

> Am Tuesday 17 February 2009 14:37:04 schrieb Laurent Riffard:
> > Le 17.02.2009 11:35, Oliver Neukum a =C3=A9crit :
> > > Am Tuesday 17 February 2009 10:55:57 schrieb Laurent Riffard:
> > >> My USB mouse won't work after suspend to disk and resume. I must=
 unload and reload the ohci_hcd module to get it back.
> > >=20
> > > Please recompile your kernel with CONFIG_USB_DEBUG and
> > > send me your dmesg.
> > >=20
> > > 	Regards
> > > 		Oliver
> > >=20
> >=20
> > Here is it:
> >=20
>=20
> Please try the attached patch.

By the way, have you tested to see if the post_reset method needs an=20
equivalent change?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
